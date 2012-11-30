require 'ffi'

module Windows
  module File
    module Functions
      extend FFI::Library
      ffi_lib :advapi32

      attach_function :EncryptFileW, [:buffer_in], :bool
      attach_function :DecryptFileW, [:buffer_in, :ulong], :bool
      attach_function :GetAce, [:pointer, :ulong, :pointer], :bool
      attach_function :GetFileSecurityW, [:buffer_in, :ulong, :pointer, :ulong, :pointer], :bool
      attach_function :GetSecurityDescriptorControl, [:pointer, :pointer, :pointer], :bool
      attach_function :GetSecurityDescriptorDacl, [:pointer, :pointer, :pointer, :pointer], :ulong
      attach_function :LookupAccountSidW, [:buffer_in, :ulong, :pointer, :pointer, :pointer, :pointer, :pointer], :bool

      ffi_lib :kernel32

      attach_function :GetVolumeInformationW,
        [:buffer_in, :buffer_out, :ulong, :pointer, :pointer, :pointer, :buffer_out, :ulong],
        :bool
    end
  end
end

class String
  # Convenience method for converting strings to UTF-16LE for wide character
  # functions that require it.
  def wincode
    (self.tr(File::SEPARATOR, File::ALT_SEPARATOR) + 0.chr).encode('UTF-16LE')
  end
end