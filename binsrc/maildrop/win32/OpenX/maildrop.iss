; Script generated by the My Inno Setup Extensions Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=OpenLink MailDrop Sink for OpenX
AppVerName=OpenLink MailDrop Sink 2.01R1
AppPublisher=Paul M. Nieuwdorp
;AppPublisherURL=http://www.pmnet.local/~paul
;AppSupportURL=http://www.pmnet.local/~paul
;AppUpdatesURL=http://www.pmnet.local/~paul
DefaultDirName=C:\MailDrop
DefaultGroupName=MailDrop Sink
AllowNoIcons=true
AlwaysCreateUninstallIcon=true


MinVersion=0,5.0.2195
AppCopyright=� 1998-2022 OpenLink Software
WizardImageFile=compiler:WizModernImage14.bmp
WizardSmallImageFile=compiler:WizModernSmallImage14.bmp
DisableStartupPrompt=true
WindowResizable=false
WindowVisible=false
WindowShowCaption=true
WizardStyle=modern
UninstallStyle=modern
WindowStartMaximized=false
AppVersion=1.0


MessagesFile=compiler:default.isl
OutputDir=..\gen
OutputBaseFilename=maildrop201R1
SourceDir=g:\binsrc\maildrop\win32\OpenX
DisableAppendDir=true
DirExistsWarning=no
UninstallLogMode=overwrite
DisableProgramGroupPage=false
DisableFinishedPage=false
CodeFile=Dialogs.ifs

AppSupportURL=http://www.openlinksw.com/
Compression=zip


; uncomment the following line if you want your installation to run on NT 3.51 too.
; MinVersion=4,3.51

[Tasks]
Name: doregister; Description: Perform Sink Registration; GroupDescription: Additional tasks:; MinVersion: 4,4

[Files]
Source: F:\virtuoso\bin\maildrop.dll; DestDir: {app}; CopyMode: alwaysoverwrite; Components: sinknormal; Flags: restartreplace
Source: F:\virtuoso\bin\maildropdbg.dll; DestDir: {app}; CopyMode: alwaysoverwrite; Components: sinkdebug; Flags: restartreplace
Source: F:\virtuoso\bin\odbc_mail.exe; DestDir: {app}; CopyMode: alwaysoverwrite
Source: odbc_mail.ini; DestDir: {app}; CopyMode: onlyifdoesntexist; Flags: confirmoverwrite
Source: readme.txt; DestDir: {app}; CopyMode: alwaysoverwrite
Source: ..\smtpreg.vbs; DestDir: {app}; CopyMode: alwaysoverwrite

[INI]
Filename: {app}\odbc_mail.ini; Section: Translate; Key: UseHostname; String: {code:FilterHostname|0}; Tasks: doregister

[Icons]
Name: {group}\OpenX Installation Instructions; Filename: {app}\readme.txt; IconIndex: 0
Name: {group}\View Sink's Debug Trace Log; Filename: c:\debug.txt; WorkingDir: {app}; IconIndex: 0; Components: sinkdebug

[Run]
Filename: {sys}\regsvr32.exe; Parameters: /s {app}\maildrop.dll; Tasks: doregister; StatusMsg: Registering COM Object; WorkingDir: {app}; Components: sinknormal
Filename: {sys}\regsvr32.exe; Parameters: /s {app}\maildropdbg.dll; Tasks: doregister; StatusMsg: Registering COM Object; WorkingDir: {app}; Components: sinkdebug
Filename: {sys}\wscript.exe; StatusMsg: Registering Sink; Parameters: "/nologo smtpreg.vbs /add 1 OnArrival ""OpenLink MailDrop"" OpenLink.MailDrop ""{code:FilterName|rcpt to=*}"""; WorkingDir: {app}; Tasks: doregister
Filename: {sys}\wscript.exe; StatusMsg: Registering Mail Delivery Program; Parameters: "/nologo smtpreg.vbs /setprop 1 OnArrival ""OpenLink MailDrop"" Sink Command ""{app}\odbc_mail.exe"""; WorkingDir: {app}; Tasks: doregister
Filename: {sys}\wscript.exe; StatusMsg: Registering Sink Properties; Parameters: "/nologo smtpreg.vbs /setprop 1 OnArrival ""OpenLink MailDrop"" Sink BounceBadMail ""{code:FilterBounce|0}"""; WorkingDir: {app}; Tasks: doregister
Filename: {app}\readme.txt; Description: View the OpenX Installation Instructions now; Flags: shellexec postinstall unchecked; WorkingDir: {app}
Filename: {app}\odbc_mail.ini; Description: Edit the odbc_mail.ini file now; Flags: shellexec postinstall unchecked; WorkingDir: {app}

[UninstallDelete]
Name: c:\debug.txt; Type: files; Components: sinkdebug

[Registry]

[_ISTool]
EnableISX=true
UseAbsolutePaths=false

[UninstallRun]
Filename: {sys}\regsvr32.exe; Parameters: /s /u {app}\maildrop.dll; Tasks: doregister; WorkingDir: {app}; Components: sinknormal
Filename: {sys}\regsvr32.exe; Parameters: /s /u {app}\maildropdbg.dll; Tasks: doregister; WorkingDir: {app}; Components: sinkdebug
Filename: {sys}\wscript.exe; Parameters: "/nologo smtpreg.vbs /remove 1 OnArrival ""OpenLink MailDrop"""; WorkingDir: {app}; Tasks: doregister

[Components]
Name: sinknormal; Description: Binaries; Flags: fixed; Types: nondebug
Name: sinkdebug; Description: Binaries (Debug); Flags: fixed; Types: debug

[Types]
Name: nondebug; Description: MailDrop Sink - Normal Build
Name: debug; Description: MailDrop Sink - Debug Build
