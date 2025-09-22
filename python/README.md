<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Python Snippets

Some bits and pieces that may be a little opaque to build from scratch. 
All codes have been tested with modern versions of Python (3.9+). 

## Setup 

The enclosed conda [environment file](./conda_env.yml) can be used to reproducibly 
create a conda environment to run examples provided here:

``` shell
conda env create -f conda_env.yml
conda activate esi-ntials
```

The environment includes iPython, so all scripts can be executed in iPython using 

``` python-console
run <scriptname.py>
```


## Custom Log Levels and Formatting

The script [log_msg.py](./log_msg.py) very briefly illustrates how to use a custom 
logging class defined in [log_setup.py](./log_setup.py). The logging class itself 
is also an example of how to customize Python's logging facilities:

- Python's logging module knows the log levels `DEBUG`, `INFO`, `WARNING`, `ERROR` 
  and `CRITICAL` 
  (see [the official docs](https://docs.python.org/3/library/logging.html#logging-levels)). 
  The module [log_setup.py](./log_setup.py) adds a custom level `ANNOUNCE`. This 
  name is arbitrary (try re-naming `ANNOUNCE` to `QUACK`) and not limited to a 
  single additional log level (try adding another log level called `DENOUNCE`)
- The formatting options in `self.FORMATS` of the `CustomLogFormatter` can be 
  freely modified to your liking (try making `INFO` bold and gray)
- The `customFmt` log format string uses some of the logging library's
  [`LogRecord` attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes). 
  (try including the filename to each emitted log message)

