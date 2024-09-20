# POC-with-headless-browser

### \*

* [Solution :](poc-with-headless-browser.md#solution-:)
* [ itext calligraphy details can be found here ](poc-with-headless-browser.md# itext-calligraphy-details-can-be-found-here )
* [PhantomJs:](poc-with-headless-browser.md#phantomjs:)
  * [Steps to use Phantom:](poc-with-headless-browser.md#steps-to-use-phantom:)
  * [Install Phantomjs inside docker:](poc-with-headless-browser.md#install-phantomjs-inside-docker:)
  * [Open issues:](poc-with-headless-browser.md#open-issues:)
* [Chrome headless browser:](poc-with-headless-browser.md#chrome-headless-browser:)
  * [Installation Details:](poc-with-headless-browser.md#installation-details:)
  * [Java code to generate html to pdf:](poc-with-headless-browser.md#java-code-to-generate-html-to-pdf:)
  * [Open issues:](poc-with-headless-browser.md#open-issues:)
  * [Open html to pdf:](poc-with-headless-browser.md#open-html-to-pdf:) Problem statement:  Conversion from html to pdf is not working as expected with Itext, if html having indic font. To over come this we explored following options.
* Need to purchase license for Itext calligraphy
* Explore phantomJs to convert html to pdf
* Explore chrome headless browser for html to pdf conversion.
* Open html tp pdf

### Solution :

### &#x20;itext calligraphy details can be found here \[\[SC-1416 supporting different languages in certificate|SC-1416-supporting-different-languages-in-certificate]]

&#x20; &#x20;

### PhantomJs:

PhantomJs is a headless browser. This is used for selenium web testing. This can be used for html to pdf/png/jpeg conversion.&#x20;

#### Steps to use Phantom:

* &#x20;Install phantomjs ([https://phantomjs.org/download.html](https://phantomjs.org/download.html))
* Change directory till phantomjs/examples and run command (phantomjs rasterize.js 'test.html' test.pdf)  test.html is input file and test.pdf is output file

#### Install Phantomjs inside docker:

install phantomjs inside docker. To support indic fonts we need to install fonts as well. find attached docker file to install phantonjs and font&#x20;

```powershell
FROM debian:stretch

ARG PHANTOM_JS_VERSION
ENV PHANTOM_JS_VERSION ${PHANTOM_JS_VERSION:-2.1.1-linux-x86_64}

# Install runtime dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install official PhantomJS release
# Install dumb-init (to handle PID 1 correctly).
# https://github.com/Yelp/dumb-init
# Runs as non-root user.
# Cleans up.
RUN set -x  \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
 && mkdir /tmp/phantomjs \
 && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_JS_VERSION}.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
 && curl -Lo /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb \
 && dpkg -i /tmp/dumb-init.deb \
 && apt-get purge --auto-remove -y \
        curl \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* \
 && useradd --system --uid 52379 -m --shell /usr/sbin/nologin phantomjs \
 && su phantomjs -s /bin/sh -c "phantomjs --version"
 RUN apt update && apt install fonts-indic -y
USER phantomjs

EXPOSE 8910

ENTRYPOINT ["dumb-init"]
CMD ["phantomjs"]] ]></ac:plain-text-body></ac:structured-macro><p><br /></p><h3>Run Phantomjs as microservice:</h3><p>We can run phantomjs as microservice to convert html to pdf as follow: <a href="https://github.com/ont/phantomjs-html2pdf">Ref</a></p><p>We need to override docker file to support language.</p><p><br /></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="b9744efc-a59e-458c-9655-c2d7093ce3e9"><ac:parameter ac:name="language">powershell</ac:parameter><ac:parameter ac:name="title">Docker to run phantom as microservice</ac:parameter><ac:parameter ac:name="linenumbers">true</ac:parameter><ac:parameter ac:name="collapse">true</ac:parameter><ac:plain-text-body><![CDATA[FROM debian:stretch

ARG PHANTOM_JS_VERSION
ENV PHANTOM_JS_VERSION ${PHANTOM_JS_VERSION:-2.1.1-linux-x86_64}

# Install runtime dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install official PhantomJS release
# Install dumb-init (to handle PID 1 correctly).
# https://github.com/Yelp/dumb-init
# Runs as non-root user.
# Cleans up.
RUN set -x  \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        curl \
 && mkdir /tmp/phantomjs \
 && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_JS_VERSION}.tar.bz2 \
        | tar -xj --strip-components=1 -C /tmp/phantomjs \
 && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
 && curl -Lo /tmp/dumb-init.deb https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb \
 && dpkg -i /tmp/dumb-init.deb \
 && apt-get purge --auto-remove -y \
        curl \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* \
 && useradd --system --uid 52379 -m --shell /usr/sbin/nologin phantomjs \
 && su phantomjs -s /bin/sh -c "phantomjs --version"
RUN apt update && apt install fonts-indic -y 
USER phantomjs

EXPOSE 8910

#ENTRYPOINT ["dumb-init"]
CMD ["phantomjs"]
##
## NOTE: to build this image you must be in the root of this repository
##

#FROM wernight/phantomjs:latest
#RUN apt update && apt install fonts-indic -y
COPY rasterize.js rasterize.js
COPY server server
EXPOSE 7777

ENTRYPOINT ["./server"]] ]></ac:plain-text-body></ac:structured-macro><p><br /></p><p>Command :</p><ul><li>Create phantom image first</li><li>docker run -d --name {service-name} -p 7777:7777  {imageName}</li><li>run curl command <p>curl -d @/home/manzarul/Downloads/certificate_school/index.html <a href="http://localhost:7777/pdf">http://localhost:7777/pdf</a> -o indextest.pdf</p></li></ul><h3>Run as java code:</h3><p>Phantomjs can be run with java code base as follow:</p><p><br /></p><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="b77c92bf-f01b-406d-abdd-5b668cc8028f"><ac:parameter ac:name="language">java</ac:parameter><ac:parameter ac:name="theme">Eclipse</ac:parameter><ac:parameter ac:name="title">Phantom with Java</ac:parameter><ac:parameter ac:name="linenumbers">true</ac:parameter><ac:parameter ac:name="collapse">true</ac:parameter><ac:plain-text-body><![CDATA[package kafka.sample;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class PhantomTest {

	private static final String htmlFilePath = "/home/manzarul/Downloads/certificate-test/index.html";
	private static final String jsFilePath = "rasterize.js";
	private static final String phantomJsFilePath = "/home/manzarul/Downloads/phantomjs-2.1.1-linux-x86_64/bin/phantomjs";
	private static final String outPutFile = "indexlatest-withzoom39-4.pdf";

	public static void main(String[] args) {
		try {
			new PhantomTest().convertHtmlToPdf(htmlFilePath, jsFilePath, phantomJsFilePath, outPutFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void convertHtmlToPdf(String htmlFilePath, String jsFilePath, String phantomJsPath, String outPutFile)
			throws Exception {
		// load html file
		File htmlFile = new File(htmlFilePath);
		// load js file that will handle render html and convert to pdf
		File configFile = new File(jsFilePath);
		// tmp pdf file for output
		File pdfReport = new File(outPutFile);
		ProcessBuilder renderProcess = new ProcessBuilder(phantomJsPath, configFile.getAbsolutePath(),
				htmlFile.getAbsolutePath(), pdfReport.getAbsolutePath());
		Process phantom = renderProcess.start();
		// you need to read phantom.getInputStream() and phantom.getErrorStream()
		// otherwise if they output something the process won't end

		int exitCode = phantom.waitFor();

		if (exitCode != 0) {
			System.out.println("Not able to generate reports.");
			System.out.println(convertInputStreamToString(phantom.getErrorStream()));
			phantom.destroy();

		} else {
			System.out.println("Pdf generated: " + pdfReport.getAbsolutePath());
			phantom.destroy();
		}

	}

	private static String convertInputStreamToString(InputStream inputStream) throws IOException {

		ByteArrayOutputStream result = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int length;
		while ((length = inputStream.read(buffer)) != -1) {
			result.write(buffer, 0, length);
		}
		inputStream.close();
		return result.toString(StandardCharsets.UTF_8.name());

	}

}


```

#### Open issues:

1. &#x20;Phantomjs is not providing any custom configuration for pdf , some configuration are provided for images ([http://phantomjs.org/documentation/](http://phantomjs.org/documentation/))
2. &#x20;Pdf generated from html is not exactly same , it has some css/style change
3. By default render pdf zoom is very high.&#x20;
4. For indic font we need to install indic font in system

### Chrome headless browser:

This is another option to convert html to pdf. To do that we need to install chrome headless browser in system.&#x20;

#### Installation Details:

apt-get update

sudo apt-get install -y libappindicator1 fonts-liberation

wget [https://dl.google.com/linux/direct/google-chrome-stable\_current\_amd64.deb](https://dl.google.com/linux/direct/google-chrome-stable\_current\_amd64.deb)

sudo dpkg -i google-chrome\*.deb

Command to generate html to pdf:

&#x20;  google-chrome --headless --disable-gpu --print-to-pdf={output\_file\_name} {path\_to\_html\_file}

&#x20;  Note:  \*\*--disable-gpu \*\* only required in windows OS

#### Java code to generate html to pdf:

```java
package practice;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.concurrent.Executors;
import java.util.function.Consumer;
public class ExcCommand {
	public static void main(String[] args) throws IOException, InterruptedException {
		try {
			String outputPdfFileName = args[0]+".pdf";
			boolean isWindows = System.getProperty("os.name")
					  .toLowerCase().startsWith("windows");
			ProcessBuilder builder = new ProcessBuilder();
			if (isWindows) {
			    builder.command("cmd.exe", "/c", "google-chrome --headless --print-to-pdf="+outputPdfFileName+" ~/workspace/practice/src/practice/index.html");
			} else {
			    builder.command("sh", "-c", "google-chrome --headless --print-to-pdf="+outputPdfFileName+" ~/workspace/practice/src/practice/index.html");
			}
			Process process = builder.start();
			StreamGobbler streamGobbler = 
					  new StreamGobbler(process.getInputStream(), System.out::println);
					Executors.newSingleThreadExecutor().submit(streamGobbler);
					int exitCode = process.waitFor();
			ProcessBuilder builder2 = new ProcessBuilder();
			builder2.command("sh", "-c", "xdg-open "+outputPdfFileName);
			Process process2 = builder2.start();
			StreamGobbler streamGobbler2 = 
					  new StreamGobbler(process2.getInputStream(), System.out::println);
					Executors.newSingleThreadExecutor().submit(streamGobbler2);
					int exitCode2 = process.waitFor();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private static class StreamGobbler implements Runnable {
	    private InputStream inputStream;
	    private Consumer<String> consumer;
	    public StreamGobbler(InputStream inputStream, Consumer<String> consumer) {
	        this.inputStream = inputStream;
	        this.consumer = consumer;
	    }
	    @Override
	    public void run() {
	        new BufferedReader(new InputStreamReader(inputStream)).lines()
	          .forEach(consumer);
	    }
	}
}
```

#### Open issues:

* &#x20;Font and style render issues ( but better than phantomjs)
* One extra blank page is appended
* Need to install indic fonts

#### Open html to pdf:

&#x20;This is open source java project for converting html to pdf . [Ref](https://github.com/danfickle/openhtmltopdf/wiki/Integration-Guide)

If any of the html tag is not closed properly then it will throw error.

|                        | PhantomJs                                        | Headless Chrome                                 | Itext | openhtmltopdf |
| ---------------------- | ------------------------------------------------ | ----------------------------------------------- | ----- | ------------- |
| Style                  | Y                                                | Y                                               | Y     | N             |
| HTML 5 support         | N                                                | Y                                               | Y     |               |
| Development support    | N(Stop since last 2 years)                       | Y                                               | Y     | Y             |
| indic language support | Y (Need to install indic fonts)                  | Y                                               | Y     | N             |
| PDF Correctness        | 80% (Need to add zoom attribute in html as 0.39) | 90% (Need to add zoom attribute in html as 98%) | 100%  | 70%           |
| Configuration          | Two file need to be config                       |                                                 |       |               |

1. rasterize.js (this is used to convert html to pdf)
2. phantomjs path

\| No Configuration required | Itext calligraphy | | | Setup | Need to install PhantomJs and indic fonts | Need to install headless chrome | No Installation required | | | Java code support | Y | Y | Y | Y |

***

\[\[category.storage-team]] \[\[category.confluence]]
