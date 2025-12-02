#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				  macOSEntitlements={"App Sandbox":"False","Hardened Runtime":"False","Notarize":"False","UserEntitlements":""}
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyWhisperBinaries
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vLi4vYmluL2dnbWwuZGxs
					FolderItem = Li4vLi4vYmluL2dnbWwtYmFzZS5kbGw=
					FolderItem = Li4vLi4vYmluL2dnbWwtY3B1LmRsbA==
					FolderItem = Li4vLi4vYmluL1NETDIuZGxs
					FolderItem = Li4vLi4vYmluL3doaXNwZXIuZGxs
				End
			End
#tag EndBuildAutomation
