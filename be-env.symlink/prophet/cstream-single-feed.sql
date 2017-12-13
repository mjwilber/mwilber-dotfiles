INSERT INTO feed_process (feed_process_id, name, cid, should_test)
 VALUES (1941, 'Carestream_Single', 19, 'T')
ON CONFLICT (feed_process_id)  DO NOTHING;

INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, last_file_ran, has_control_file)
  SELECT 19410, 'TSTMATSUPPLY', fp.feed_process_id, 38, 1, 1, 'T', NULL, 'T'
   FROM feed_process fp
   WHERE fp.name = 'Carestream_Single'
ON CONFLICT (fid)
  DO UPDATE SET last_file_ran = NULL;

