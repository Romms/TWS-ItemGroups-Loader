Get-ChildItem "./" -Filter *.sfproj | 
	Foreach-Object {
		$ProjectFileName = $_.FullName | Resolve-Path -Relative
		$ItemGroupsFileName = $ProjectFileName + '.ItemGroups'

		Try {
			[XML]$ProjectDocument = Get-Content $ProjectFileName
			$ItemGroupsDocument = New-Object System.XML.XMLDocument

			$ItemGroupsDocument.InsertBefore($ItemGroupsDocument.CreateXmlDeclaration("1.0", "utf-8", $null), $ItemGroupsDocument.DocumentElement) | Out-Null
			$ItemGroupsDocument.appendChild($ItemGroupsDocument.createElement('ItemGroups', $ProjectDocument.DocumentElement.NamespaceURI)) | Out-Null

			$ItemGroups = $ProjectDocument.Project.ItemGroup;
			$ItemGroups | foreach { 
				$ItemGroupsDocument.DocumentElement.AppendChild($ItemGroupsDocument.ImportNode($_, $true)) | Out-Null
			}

			$ItemGroupsDocument.Save((Resolve-Path $ItemGroupsFileName))

			Write-Host $ProjectFileName -NoNewline 
			Write-Host " --> " -foregroundcolor "green" -NoNewline 
			Write-Host $ItemGroupsFileName
		} Catch {
			Write-Host $_.Exception.Message -foregroundcolor "red"
			Write-Host $_.Exception.ItemName -foregroundcolor "red"
		}
	}