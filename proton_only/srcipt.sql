
CREATE EXTERNAL STREAM proton_log(
    raw string
) 
SETTINGS 
    type='log', 
    log_files='proton-server.log', 
    log_dir='/var/log/proton-server', 
    timestamp_regex='^(\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d+)', 
    row_delimiter='(\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d+) \[ \d+ \] \{'


CREATE EXTERNAL STREAM proton_err_log(
    raw string,
    _tp_time ALIAS to_time(extract(raw, '^(\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d+)')),
    level ALIAS extract(raw, '} <(\w+)>'),
    message ALIAS extract(raw, '} <\w+> (.*)'))
SETTINGS
type='log',
log_files='proton-server.err.log*',
log_dir='/var/log/proton-server',
row_delimiter='(\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d+) \[ \d+ \] \{',
timestamp_regex='^(\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}\.\d+)';