#!/bin/sh

# TODO:
#  - Use PAGER instead of just assuming less
#  - Add html log
#  - On updates generate an html log from old-rev to current rev
#

me=$0
bme=`basename "$0"`

SVN=svn
  # ---------------- #
  # Helper functions #
  # ---------------- #

set_colors()
{
  red='[0;31m';    lred='[1;31m'
  green='[0;32m';  lgreen='[1;32m'
  yellow='[0;33m'; lyellow='[1;33m'
  blue='[0;34m';   lblue='[1;34m'
  purple='[0;35m'; lpurple='[1;35m'
  cyan='[0;36m';   lcyan='[1;36m'
  grey='[0;37m';   lgrey='[1;37m'
  white='[0;38m';  lwhite='[1;38m'
  std='[m'
}

set_nocolors()
{
  red=;    lred=
  green=;  lgreen=
  yellow=; lyellow=
  blue=;   lblue=
  purple=; lpurple=
  cyan=;   lcyan=
  grey=;   lgrey=
  white=;  lwhite=
  std=
}


svn_revision()
{
    svn_revision_info_out=`$SVN info "$@"`
    svn_revision_rv=$?
    echo "$svn_revision_info_out" | sed '/^Revision: /!d;s///'
    return $svn_revision_rv
}


svn_version()
{
    $SVN --version
}

svn_help()
{
  if [ $# -eq 0 ]; then
    svn_version
    $SVN help
    rv=$?
    echo '
Additional commands provided by svn-wrap:
  ignore
  report
  revision (rev)
  version
  weekreport'
    return $rv
  else
    case $1 in
      ignore )
        what='svn:ignore property'
        cat <<EOF
ignore: Add some files in the $what.
usage: 1. ignore [PATH]
       2. ignore FILE [FILES...]

 1. Display the value of $what on [PATH].
 2. Add some files in the $what of the directory containing them.

When adding ignores, each pattern is ignored in its own directory, e.g.:
  $bme ignore dir/file "d2/*.o"
Will put 'file' in the $what of 'dir' and '*.o' in the
$what of 'd2'

Valid options:
  None.
EOF
        ;;
      report | rep) cat <<EOF
Generate a report of the revisions specfied by -r as in svn merge
EOF
        ;;
      weekreport | wr) cat <<EOF
Generate a report of the revisions made in the last week (~8days)
  Optional args:
    -u [username]   Specify an username or default to current id's name to filter report
EOF
        echo "";
        echo "Generate a report of the revisions made in the last week (~8days)";
        echo "  Optional args:";
        echo "    -u [username]   Specify an username or default to current id's name to filter report";
        echo "";
        ;;
      revision | rev)
        echo 'revision (rev): Display the revision number of a local or remote item.'
        $SVN help info | sed '1d;
                              s/information/revision/g;
                              s/revision about/the revision of/g;
                              2,35 s/info/revision/g;
                              /-xml/d'
        ;;
      *)
	  	$SVN help "$@"
		;;
    esac
  fi
}

svn_status()
{
  svn_status_out=`$SVN status "$@"`
  svn_status_rv=$?
  test -z "$svn_status_out" && return $svn_status_rv
  echo "$svn_status_out" | sed "$sed_svn_st_color"
  return $svn_status_rv
}

svn_update()
{
  old_rev=`svn_revision || abort 'Cannot get current revision number'`
  svn_update_out=`$SVN update "$@"`
  svn_update_rv=$?
  echo "$svn_update_out" | sed "$sed_svn_up_colors"
  new_rev=`svn_revision || abort 'Cannot get updated revision number'`
  if [ $old_rev -ne $new_rev ]; then
	  $SVN log -r $old_rev:$new_rev | svnupdate2html.awk > /tmp/${PBRANCH}-update-`date +%F-%H%M`.html
	  echo "Update log available at: file:///tmp/${PBRANCH}-update-`date +%F-%H%M`.html"
  fi
  return $svn_update_rv
}

svn_ignore()
{
  if [ $# -eq 0 ]; then  # Simply display ignore-list.
    $SVN propget 'svn:ignore'
  elif [ $# -eq 1 ]; then
    b=`basename "$1"`
    d=`dirname "$1"`
    svn_propadd 'svn:ignore' "$b" "$d"
  else                   # Add arguments in svn:ignore.
    # This part is a bit tricky:
    # For each argument, we find all the other arguments with the same dirname
    # $dname and we svn:ignore them all in $dname.
    while [ $# -ne 0 ]; do
      arg=$1
      dname=`dirname "$1"`
      files=`basename "$1"`
      shift
      j=0; argc=$#
      while [ $j -lt $argc ] && [ $# -ne 0 ]; do
        this_arg=$1
        shift
        this_dname=`dirname "$this_arg"`
        this_file=`basename "$this_arg"`
        if [ x"$dname" = x"$this_dname" ]; then
          files="$files
$this_file"
        else
          set dummy "$@" "$this_arg"
          shift
        fi
        j=$(($j + 1))
      done
      svn_propadd 'svn:ignore' "$files" "$dname"
    done
  fi

}

svn_report()
{
  #debug: echo "Args: $#: $@"
  old_rev=`svn_revision || abort 'Cannot get updated revision number'`
  new_rev=`svn_revision || abort 'Cannot get updated revision number'`
  while getopts r: o
  do
      case "$o" in
	  r)	revision="$OPTARG";
			case "$revision" in
			*:*)
			    old_rev=`echo $revision | cut -d: -f1`
				new_rev=`echo $revision | cut -d: -f2`
				;;
			*)  old_rev=$revision
			esac
			;;
	  esac
  done
  test -z "$revision" && return 1;

  #debug: echo "Going to log from old:$old_rev to new:$new_rev"
  #debug: return;

  if [ $old_rev != $new_rev ]; then
	  $SVN log -r $old_rev:$new_rev | svnupdate2html.awk > /tmp/${PBRANCH}-report-`date +%F-%H%M`.html
	  echo "Update log available at: file:///tmp/${PBRANCH}-report-`date +%F-%H%M`.html"
  else
      echo "Unchanged versions: nothing to report"
  fi
}

svn_weeks_report()
{
  case $1 in
    -u) export SVN_REPORT_BY_USER=${2:-`id -u -n`};
        ;;
    *) break ;;
  esac
  
  echo SVN_REPORT_BY_USER = [$SVN_REPORT_BY_USER]
  [ -n "$SVN_REPORT_BY_USER" ] &&  echo "Generating report for only versions by $SVN_REPORT_BY_USER"
  $SVN log -r {`date -d -8days +%Y-%m-%d`}:HEAD | svnupdate2html.awk > /tmp/${PBRANCH}-weeksreport-`date +%F-%H%M`.html
  unset SVN_REPORT_BY_USER;
	echo "Update log available at: file:///tmp/${PBRANCH}-weeksreport-`date +%F-%H%M`.html"
}
#########################################################################
#
#                     M A I N 
#
#########################################################################

# Define colors if stdout is a tty.
if test -t 1; then
  set_colors
else # stdout isn't a tty => don't print colors.
  set_nocolors
fi

# Consider this as a sed function :P.
sed_svn_st_color="
    t dummy_sed_1
    : dummy_sed_1
    s@^?\\(......\\)+@+\\1+@
    s@^?\\(......\\)\\(.*/\\)+@+\\1\\2+@
    s@^?\\(......\\),@,\\1,@
    s@^?\\(......\\)\\(.*/\\),@,\\1\\2,@
    s/^\\(.\\)C/\\1${lred}C${std}/
    t dummy_sed_2
    : dummy_sed_2
    s/^?/${lred}?${std}/;  t
    s/^M/${lgreen}M${std}/;  t
    s/^A/${lgreen}A${std}/;  t
    s/^X/${lblue}X${std}/;   t
    s/^+/${lyellow}+${std}/; t
    s/^D/${lyellow}D${std}/; t
    s/^,/${lred},${std}/;    t
    s/^C/${lred}C${std}/;    t
    s/^I/${purple}I${std}/;  t
    s/^R/${lblue}R${std}/;   t
    s/^!/${lred}!${std}/;    t
    s/^~/${lwhite}~${std}/;  t"

sed_svn_up_colors="
    t dummy_sed_1
    : dummy_sed_1
    $           q
    /^Updated/  t
    /^Fetching/ t
    /^External/ t
    s/^\\(.\\)C/\\1${lred}C${std}/
    s/^\\(.\\)U/\\1${lgreen}U${std}/
    s/^\\(.\\)D/\\1${lred}D${std}/
    t dummy_sed_2
    : dummy_sed_2
    s/^A/${lgreen}A${std}/;  t
    s/^U/${lgreen}U${std}/;  t
    s/^D/${lyellow}D${std}/; t
    s/^G/${purple}G${std}/;  t
    s/^C/${lred}C${std}/;    t"

case $1 in

  # ------------------------------- #
  # Hooks for standard SVN commands #
  # ------------------------------- #
  help | \? | h)
    shift
    svn_help "$@"
    ;;
  report | rep )
    shift
    svn_report "$@"
    cmd_response=$?
    if [ $cmd_response -gt 0 ]; then
        echo "svn: Try 'svn help for more info"
        if [ $cmd_response -gt 0 ]; then
            echo "svn: Not enough arguments provided"
        fi
    fi
    ;;
  weekreport | wr)
    shift
    svn_weeks_report "$@"
    ;;
  version )
    shift
    svn_version "$@"
    ;;
  status | stat | st)
    shift
    svn_status "$@"
    ;;
  update | udpate | up)
    shift
    svn_update 
    ;;

  # -------------------------- #
  # Non-standard SVN commands  #
  # -------------------------- #
  ignore)
    shift
    svn_ignore "$@"
    ;;
  log)
    # pipe svn log through PAGER(less) by default
    exec $SVN "$@" | less
    ;;

  # --------------------------------------- #
  # Fall through for unchanged svn commands #
  # --------------------------------------- #
  *)
    exec svn "$@"
    ;;
esac


