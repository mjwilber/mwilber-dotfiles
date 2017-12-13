-- UPDATE feed_notify SET email = 'mwilber@bybaxter.com';




INSERT INTO feed_process (feed_process_id, name, cid, should_test)
                  VALUES (3450, 'Globex_MWilber_Test', 34, 'F');

-- Create an optional/ignore feed if not found
INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, has_control_file)
          VALUES (3451, 'PROD', 3450,         6,    0,             1,        'T',     'F');

-- Create an optional/ignore feed if not found
INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, has_control_file)
          VALUES (3452, 'MAT', 3450,          3,    1,             2,        'T',     'F');

-- Create an optional/ignore feed if not found
INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, has_control_file)
          VALUES (3453, 'OMATSUPPLY', 3450,   38,   1,             3,        'T',     'F');

-- Create an optional/ignore feed if not found
INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, has_control_file)
          VALUES (3454, 'SITE', 3450,         25,   1,             5,        'T',     'F');

-- Create an optional/ignore feed if not found
INSERT INTO feed (fid, name, feed_process_id, ftid, required_type, sequence, enabled, has_control_file)
          VALUES (3455, 'INVENTORY', 3450,    36,   1,             7,        'T',     'F');
