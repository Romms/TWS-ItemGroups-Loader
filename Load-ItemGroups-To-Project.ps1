Get-ChildItem "./" -Filter *.sfproj.ItemGroups | 
	Foreach-Object {
		$ItemGroupsFileName = $_.FullName | Resolve-Path -Relative
		$ProjectFileName = $ItemGroupsFileName -replace "\.ItemGroups$", ""
		
		[XML]$ItemGroupsDocument = Get-Content $ItemGroupsFileName
		[XML]$ProjectDocument = Get-Content $ProjectFileName
		
		$ProjectDocument.Project.ItemGroup | foreach {
			$_.ParentNode.RemoveChild($_) | Out-Null
		}

		$ItemGroups = $ItemGroupsDocument.ItemGroups.ItemGroup
		$ItemGroups | foreach { 
			$ProjectDocument.DocumentElement.AppendChild($ProjectDocument.ImportNode($_, $true)) | Out-Null
		}
		
		$ProjectDocument.Save((Resolve-Path $ProjectFileName))
		
		Write-Host $ProjectFileName -NoNewline 
		Write-Host " <-- " -foregroundcolor "green" -NoNewline 
		Write-Host $ItemGroupsFileName
	}