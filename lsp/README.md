# What the lsp does

Automatically creates `.cfmlsp` folder within your project.
Adds a default `.cfmlsp/profile.xml` to the project, which contains a lot of options that are handed to the lsp.


# Adding coldfusion mappings

If you have some coldfusion mappings within your project, you can add them here:
`.cfmlsp/ColdfusionLSDefaultWorkspace/CF_DEFAULT_PROJECT/settings.xml`

This is a valid template
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<ResourceDetails>
	<ServerName>localhost</ServerName>
	<LauncherName></LauncherName>
	<ExternalBrowser></ExternalBrowser>
	<UseStartPage>false</UseStartPage>
	<StartPage useextension="false" ></StartPage>

	<Mappings>
		<Mapping-Name></Mapping-Name>
		<Location></Location>
	</Mappings>
	
	<VariableMappings>
		<VariableName>awesomeService</VariableName>
		<MappedTo>classes.subfolder.AwesomeServiceThing</MappedTo>
	</VariableMappings>

	<DictionaryVersion>ColdFusion2023</DictionaryVersion>
	<CFCMappings>
		<MappingName>view</MappingName>
		<Path>project/classes/view</Path>
		<MappingName>controller</MappingName>
		<Path>project/classes/controller</Path>
	</CFCMappings>

</ResourceDetails>
```
