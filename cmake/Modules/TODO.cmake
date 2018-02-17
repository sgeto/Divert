include(CheckIncludeFile)

# XXX - turn these into macros

CHECK_INCLUDE_FILE(ntddk.h HAVE_NTDDK_H)
if(NOT HAVE_NTDDK_H)
FIND_PATH(NTDDK_H_INCLUDE_DIR ntddk.h)
message(WARNING "NTDDK_H_INCLUDE_DIR: ${NTDDK_H_INCLUDE_DIR}!!!!")
if(NTDDK_H_INCLUDE_DIR)
  include_directories(${NTDDK_H_INCLUDE_DIR})
else()
  message(FATAL_ERROR "ntddk.h not found! See README.CMAKE for more information.")
endif()

FIND_LIBRARY(HAVE_FWPKCLNT fwpkclnt)
if(HAVE_FWPKCLNT)
    set(EC_LIBETTERCAP_LIBS ${EC_LIBETTERCAP_LIBS} ${HAVE_FWPKCLNT})
else()
    message(FATAL_ERROR "fwpkclnt.lib not found!")
endif()

FIND_LIBRARY(HAVE_NDIS ndis)
FIND_LIBRARY(HAVE_UUID uuid)
FIND_LIBRARY(HAVE_wdmsec wdmsec)

# $(DDK_LIB_PATH)\wdmsec.lib
# $(DDK_LIB_PATH)\ndis.lib
# $(DDK_LIB_PATH)\fwpkclnt.lib
# $(SDK_LIB_PATH)\uuid.lib

CHECK_INCLUDE_FILE(sys/select.h HAVE_SYS_SELECT_H)
CHECK_INCLUDE_FILE(sys/utsname.h HAVE_UTSNAME_H)

TODO
----

ADD_DEFINITIONS(-DBINARY_COMPATIBLE=0)
ADD_DEFINITIONS(-DNT)
ADD_DEFINITIONS(-DNDIS60)
ADD_DEFINITIONS(-DNDIS_SUPPORT_NDIS60)


# preprocessor definitions
# BINARY_COMPATIBLE=0
# NT
# NDIS60
# NDIS_SUPPORT_NDIS60

# !!!!inherited:!!!
# _WIN64
# _AMD64_
# AMD64
# DEPRECATE_DDK_FUNCTIONS=1
# MSC_NOOPT
# _WIN32_WINNT=$(WIN32_WINNT_VERSION) = 0x0A00
# WINVER=$(WINVER_VERSION) = 0x0A00
# WINNT=1
# NTDDI_VERSION=$(NTDDI_VERSION) = 0x0A000002
# %(ClCompile.PreprocessorDefinitions)


# include directories
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\km\crt
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\km
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\shared
# C:\Program Files (x86)\Windows Kits\10\Include\wdf\kmdf\1.15
# corresponding to:
# $(CRT_IncludePath)
# $(KM_IncludePath)
# $(KIT_SHARED_IncludePath)
# $(KMDF_INC_PATH)$(KMDF_VER_PATH)

# library directories
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib\amd64
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\atlmfc\lib\amd64
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\ucrt\x64
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\um\x64
# corresponding to:
# $(DDK_LibraryPath_DDKPlatform)
# $(VC_LibraryPath_x64)
# $(WindowsSDK_LibraryPath_x64)
# $(NETFXKitsDir)Lib\um\x64

# excluded directories!!!!!!!!
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\atlmfc\include
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\ucrt
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\um
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\shared
# corresponding to:
# $(VC_IncludePath)
# $(WindowsSDK_IncludePath)
# $(MSBuild_ExecutablePath)
# $(VC_LibraryPath_x64)

# additional dependancies!!!!!!!!!!!
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\wdmsec.lib
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\ndis.lib
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\fwpkclnt.lib
# C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\um\x64\\uuid.lib
# %(AdditionalDependencies)
# corresponding to:
# $(DDK_LIB_PATH)\wdmsec.lib
# $(DDK_LIB_PATH)\ndis.lib
# $(DDK_LIB_PATH)\fwpkclnt.lib
# $(SDK_LIB_PATH)\uuid.lib
# !!! default libraries!!!
# $(KernelBufferOverflowLib)
# $(DDK_LIB_PATH)ntoskrnl.lib
# $(DDK_LIB_PATH)hal.lib
# $(DDK_LIB_PATH)wmilib.lib
# $(KMDF_LIB_PATH)$(KMDF_VER_PATH)\WdfLdr.lib
# $(KMDF_LIB_PATH)$(KMDF_VER_PATH)\WdfDriverEntry.lib

# recource file handling
# XXX - simply add it to windivert's sources in cmake?

# command line:
# rc.exe /I"C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\um" /I"x64\Debug\" /D "_WIN64" /D "_AMD64_=1" /D "AMD64" /D "DEPRECATE_DDK_FUNCTIONS=1" /D "MSC_NOOPT" /D "_WIN32_WINNT=0x0A00" /D "WINVER=0x0A00" /D "WINNT=1" /D "NTDDI_VERSION=0x0A000002" /D "DBG=1" /D "SMP_ID=\\"{1bc93793-694f-48fe-9372-81e2b05556fd}\\"" /l 0x0409 /nologo /fo"x64\Debug\%(Filename).res" 

# driver package/singing
# command line:
# ??

# inftool/catalog stuff
# command line:
# StampInf:
  # C:\Program Files (x86)\Windows Kits\10\bin\x86\stampinf.exe -d "*" -a "amd64" -v "*" -k "1.15"  -x -f x64\Debug\windivert64.inf
  # Copying "C:\Users\Ali\projects\Divert\inf\windivert64.inf" to "x64\Debug\windivert64.inf" for stamping
  # Stamping x64\Debug\windivert64.inf [Version] section with DriverVer=02/11/2018,1.14.7.961

# inf2cat.exe /os:"10_x64" /uselocaltime 

# TestSign:
  # The driver will be test-signed. Driver signing options can be changed from the project properties.
  # Sign Inputs: C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.sys
  # C:\Program Files (x86)\Windows Kits\10\bin\x86\signtool.exe sign /ph /sha1 "7F80E4A644655027516CB39AE9CD2558035796BD"
  # Done Adding Additional Store
  # Successfully signed: C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.sys

  # Certificate used for signing: issued to = WDKTestCert Ali,131510638525444797 and thumbprint = 7F80E4A644655027516CB39AE9CD2558035796BD
  # Exported Certificate: C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.cer
# Done Building Project "C:\Users\Ali\projects\Divert\WinDivert\WinDivert.vcxproj" (TestSign target(s)).

# XXX - make this part of tests???
# ApiValidator:
  # Validating universal driver using ApiValidator.exe
  # cmd.exe /C "C:\Users\Ali\AppData\Local\Temp\tmp469b68ba610843b0b68d5f6ad8dd2815.cmd"
  # "C:\Program Files (x86)\Windows Kits\10\bin\x64\ApiValidator.exe" -DriverPackagePath:C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\ -SupportedApiXmlFiles:"C:\Prog
  # ram Files (x86)\Windows Kits\10\build\universalDDIs\x64\UniversalDDIs.xml" -ModuleWhiteListXmlFiles:"C:\Program Files (x86)\Windows Kits\10\build\universalDDIs\x64\M
  # oduleWhiteList.xml" -ApiExtractorExePath:"C:\Program Files (x86)\Windows Kits\10\bin\x64"
  # Driver is a Universal Driver.

# compiler command line

# cl.exe /GS- /W3 /wd"4214" /wd"4211" /wd"4748" /wd"4603" /wd"4627" /wd"4986" /wd"4987" /wd"4996" /Gy /Zc:wchar_t- /I"C:\Users\Ali\projects\Divert\WinDivert\..\include\" /I"x64\Debug\" /analyze:"stacksize1024" /Zi /Gm- /Od /Fd"x64\Debug\vc140.pdb" /FI"C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\shared\warning.h" /Zc:inline /fp:precise /Zp8 /D "BINARY_COMPATIBLE=0" /D "NT" /D "UNICODE" /D "_UNICODE" /D "NDIS60" /D "NDIS_SUPPORT_NDIS60" /D "_WIN64" /D "_AMD64_" /D "AMD64" /D "DEPRECATE_DDK_FUNCTIONS=1" /D "MSC_NOOPT" /D "_WIN32_WINNT=0x0601" /D "WINVER=0x0601" /D "WINNT=1" /D "NTDDI_VERSION=0x06010000" /D "DBG=1" /errorReport:prompt /GF /WX- /Zc:forScope /GR- /Gz /Oy- /Oi /Fa"x64\Debug\" /nologo /Fo"x64\Debug\" /Fp"x64\Debug\WinDivert64.pch"

# linker command line

# link.exe /OUT:"C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.sys" /MANIFEST:NO /PROFILE /Driver /PDB:"C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.pdb" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\wdmsec.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\ndis.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\\fwpkclnt.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\um\x64\\uuid.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\BufferOverflowK.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\ntoskrnl.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\hal.lib" "C:\Program Files (x86)\Windows Kits\10\lib\10.0.14393.0\km\x64\wmilib.lib" "C:\Program Files (x86)\Windows Kits\10\lib\wdf\kmdf\x64\1.9\WdfLdr.lib" "C:\Program Files (x86)\Windows Kits\10\lib\wdf\kmdf\x64\1.9\WdfDriverEntry.lib" /RELEASE /VERSION:"10.0" /MACHINE:X64 /ENTRY:"FxDriverEntry" /WX /OPT:NOREF /INCREMENTAL:NO /PGD:"C:\Users\Ali\projects\Divert\WinDivert\x64\Debug\WinDivert64.pgd" /SUBSYSTEM:NATIVE",6.01" /OPT:NOICF /ERRORREPORT:PROMPT /MERGE:"_TEXT=.text;_PAGE=PAGE" /NOLOGO /NODEFAULTLIB /SECTION:"INIT,d"

# stuff for summary:
# DriverBuildNotifications:
  # Building 'WinDivert' with toolset 'WindowsKernelModeDriver10.0' and the 'Universal' target platform.
  # Using KMDF 1.15.