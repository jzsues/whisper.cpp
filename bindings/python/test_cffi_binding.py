from idlelib.iomenu import encoding

from _whisper_cpp import ffi, lib


print(f'whisper_print_system_info: {ffi.string(lib.whisper_print_system_info())}')