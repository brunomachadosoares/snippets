import os
from contextlib import contextmanager

""" The idea here, is to bypass some exception
that you known it is unecessary,
so this is a beautiful way to do the job"""

@contextmanager
def ignored(*exceptions):
    try:
        yield
    except exceptions:
         pass


with ignored(OSError):
    os.remove('not_existent_file.bin')
