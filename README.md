# About this repository
This is a small project I started with some free time. I'm currently being trained to be a Salesforce developer.

Some time ago I was studying the Salesforce Migration Tool, and it's usage with Continuous Integration software (in my case, Atlassian's Bamboo). I thought that it was really overkill to use such a tool to simply call commands such 'deploy to org' or 'retrieve metadata from org', in which the tool simply calls Ant to do those tasks and put the files in the folders.
Anyway, I understood (more or lees) what the tool did, and how it worked. So I tried to replicate the features in one single application.

JadeSnake is that app. And currently it does one of the steps I mentioned (retrieve metadata from a Salesforce organization). Next step would be, quite obviously, to do the code deployment part.

The home page is just a static page for now, so it can be ignored. Projects, organizations and build plans can be registered in the app. JadeSnake saves this information in a .db SQLite3 file.

# What it currently does

At the moment, the app is able to retrieve metadata information from a Salesforce organization. The metadata is specified in a package.xml file inside the project's folder. One of the features of JadeSnake would be to edit this file in a customized interface.

# What it does not do

Pretty much everything else aside from retrieve organization metadata.
