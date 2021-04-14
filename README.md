
## Already Implemented

* Implemented fetching a license from SPDX master files.
* Implemented parsing the xml file and extracting the license name, SPDX identifier and license body.
* Implemented the code to fetch the tarball of a package from pub and locating its LICENSE.
	* Will be used for testing and corner case detection
* Working on a normalizer class to normalize the license as per License Classifer v2 and the SPDX guidelines. 
  * strip new lines and carriage returns
  * strip spaces
  * strip all punctuation, quote and parenthesis
  * trim copyright symbols and notice
  * replace equivalent words
  * strip comments
  * strip any other optional text
* Implemented a class to tokenize a supplied string based on delimeters.



A simple command-line application.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
