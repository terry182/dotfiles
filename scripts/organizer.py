import argparse
import os
from argparse import ArgumentTypeError as err
import hashlib


# reference: https://stackoverflow.com/questions/11415570/directory-path-types-with-argparse
class PathType(object):
    def __init__(self, exists=True, type='file', dash_ok=True):
        '''exists:
                True: a path that does exist
                False: a path that does not exist, in a valid parent directory
                None: don't care
           type: file, dir, symlink, None, or a function returning True for valid paths
                None: don't care
           dash_ok: whether to allow "-" as stdin/stdout'''

        assert exists in (True, False, None)
        assert type in ('file','dir','symlink',None) or hasattr(type,'__call__')

        self._exists = exists
        self._type = type
        self._dash_ok = dash_ok

    def __call__(self, string):
        if string=='-':
            # the special argument "-" means sys.std{in,out}
            if self._type == 'dir':
                raise err('standard input/output (-) not allowed as directory path')
            elif self._type == 'symlink':
                raise err('standard input/output (-) not allowed as symlink path')
            elif not self._dash_ok:
                raise err('standard input/output (-) not allowed')
        else:
            e = os.path.exists(string)
            if self._exists==True:
                if not e:
                    raise err("path does not exist: '%s'" % string)

                if self._type is None:
                    pass
                elif self._type=='file':
                    if not os.path.isfile(string):
                        raise err("path is not a file: '%s'" % string)
                elif self._type=='symlink':
                    if not os.path.symlink(string):
                        raise err("path is not a symlink: '%s'" % string)
                elif self._type=='dir':
                    if not os.path.isdir(string):
                        raise err("path is not a directory: '%s'" % string)
                elif not self._type(string):
                    raise err("path not valid: '%s'" % string)
            else:
                if self._exists==False and e:
                    raise err("path exists: '%s'" % string)

                p = os.path.dirname(os.path.normpath(string)) or '.'
                if not os.path.isdir(p):
                    raise err("parent path is not a directory: '%s'" % p)
                elif not os.path.exists(p):
                    raise err("parent directory does not exist: '%s'" % p)

        return string


RULES = {
    "Pictures": [".jpeg", ".jpg", ".tiff", ".gif", ".bmp", ".png", ".bpg", "svg",
               ".heif", ".psd"],
    "Video": [".avi", ".flv", ".wmv", ".mov", ".mp4", ".webm", ".vob", ".mng",
               ".qt", ".mpg", ".mpeg", ".3gp"],
    "Documents": [".oxps", ".epub", ".pages", ".docx", ".doc", ".fdf", ".ods",
                  ".odt", ".pwi", ".xsn", ".xps", ".dotx", ".docm", ".dox",
                  ".rvg", ".rtf", ".rtfd", ".wpd", ".xls", ".xlsx", ".ppt",
                  "pptx", ".txt"],
    "Archives": [".a", ".ar", ".cpio", ".iso", ".tar", ".gz", ".rz", ".7z",
                 ".dmg", ".rar", ".xar", ".zip", ".jar", ".bin"],
    "Audio": [".aac", ".aa", ".aac", ".dvf", ".m4a", ".m4b", ".m4p", ".mp3",
              ".msv", "ogg", "oga", ".raw", ".vox", ".wav", ".wma"],
    "PDFs": [".pdf"],
    "Presentation": [".ppsx", ".ppt", ".pptx", ".keynote"],
    "Books": [".mobi", ".epub", ".azw3"]
}

def find_duplicates(path, file_list: [str]):

    # Reference: https://stackoverflow.com/questions/22058048/hashing-a-file-in-python
    def hash_file(file_name):
        h = hashlib.sha256()
        b = bytearray(128*1024)
        mv = memoryview(b)
        with open(file_name, 'rb', buffering=0) as f:
            for n in iter(lambda : f.readinto(mv), 0):
                h.update(mv[:n])
        return h.hexdigest()

    hashes = {file: hash_file(os.path.join(path, file)) for file in reversed(sorted(file_list))}

    table = set()
    duplicates = []

    for name, hash in hashes.items():
        if hash not in table:
            table.add(hash)
        else:
            duplicates.append(name)

    return duplicates



def cleanup(path, file_list, rules=RULES):
    reverse_rule = { ext : directory for directory, extensions in rules.items() for ext in extensions} 
    for file_name in file_list:
        ext = os.path.splitext(file_name)[-1]
        folder = reverse_rule[ext.lower()] if ext.lower() in reverse_rule else 'Other'
        folder_path = os.path.join(path, folder)
        os.makedirs(folder_path, exist_ok=True)
        os.rename(os.path.join(path, file_name),  os.path.join(folder_path, file_name))


# is_file = lambda name: os.path.isfile(name) or (os.path.isdir(name) and os.path.splitext(name)[-1] == '.app')
is_file = os.path.isfile


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', metavar='path', type=PathType(exists=True, type='dir'), help='the path which need to be organized')

    args = parser.parse_args()

    path = args.path

    file_list = [file for file in os.listdir(path) if is_file(os.path.join(path, file)) ]

    duplicate_folder = os.path.join(path, 'Duplicates')

    if os.path.exists(duplicate_folder) and is_file(duplicate_folder):
        print(f'Cannot remove duplicates as {duplicate_folder} is a file')
    else:
        duplicates = find_duplicates(path, file_list)
        print(f'[DEBUG] {len(duplicates)} duplicate(s) found.')
        if len(duplicates) > 0 and os.path.exists(duplicate_folder) == False:
            print(f'[DEBUG] Create folder {duplicate_folder}.')
            os.mkdir(duplicate_folder)
        for name in duplicates:
            os.rename(os.path.join(path, name),  os.path.join(duplicate_folder, name))

        file_list = [file for file in file_list if file not in duplicates]
        print(file_list)
        print('[DEBUG] Done moving duplicates')
    
    cleanup(path, file_list)
    print('[DEBUG] Done organizing')
