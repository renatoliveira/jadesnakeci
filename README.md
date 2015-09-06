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

# Requirements

- Python 3.3+
- Bottle (http://bottlepy.org/)
- SQLite3 (bundled with Python 3.4)
- Apache Ant (http://ant.apache.org/) added in the machine's PATH

# License

The MIT License (MIT)

Copyright (c) 2015 Renato Oliveira

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
