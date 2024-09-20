# Video-streaming

\*\*Introduction: \*\* This wiki explains the design and implementation to streaming of video contents.

**Background:** With the help of [videojs(v7.07)](https://github.com/videojs/video.js) user can able to stream the content rather than making user to wait until video to get download.

**Problem Statement:** Currently, Content Player is bundled with videojs(v.5.0.0) version which is unsupported for the video streaming contents.

After upgrading videojs(5.0.0) to videojs(7.0.0) to should able support below cases.

* New version of the content-player should support for the old contents(Unstreamed mp4 contents).
* Newley created streaming content should not visible in the old version of content-player

**Solution 1:   Content config Data should have streaming video config** For the newly created content, player will accept the config for the video streaming so latest version of content player will stream the video based on the config.

```
config={
      videoStreaming:true
}
```

**Pros:** &#x20;

&#x20;     1.Old contents still will play as it is. will not going to break the contract.

\*\*Cons: \*\*

&#x20;    1.To identify the streaming url the mobile as to send extra property

**Solution 2: New streaming mime type content** Currently content-player supports the below video mime type contents all these mime type contents are launched by **org.ekestep.videorenderer-1.0** plugin.

* **video/mp4**
* **video/x-youtube**
* **video/webm**

Similarly new mimetype  for the video streaming content should be handled by new plugin **org.ekstep.videostreaming-1.0** plugin, this plugin will be having lates version of videojs(v7.0.0).

When the user creates any mp4/Webm video contents with respective mimetype then sunbird learning platform will convert m4/webm to azure/s3 streaming contents along it should convert the content mimetype as well from (mp4/webm) to video streaming mimetype

**Pros** **:**

\*\*     \*\* 1. Old contents still will play as it is in the new version of the content-player with out breaking the contract.

&#x20;  &#x20;

**Cons:**

1. Need to maintain the multiple version of **video js** library.

**Solution 3: Content Migration** Migrate all mp4/webm contents to streaming format so then new version of content-player will play the contents without breaking the contract.

**Pros:**

1. Easy maintain - Uniq version of videojs lib will be present in the content-player.

**Cons:**

&#x20;     2\. The contents which is already downloaded in the mobile will not be going to play in the new version content-player.

**Solution 4: Content player Should detect the streaming url.** The content player should find weather is mp4/web/streaming url with the help of the asset extension.

**Sample streaming url link:**  [http://sunbirdspikemedia-inct.streaming.media.azure.net/afcc5a99-d0c4-4ef5-9dfe-dc403a1269fb/learn-colors-with-numbers-in-kid.ism/manifest(format=m3u8-aapl-v3)](http://sunbirdspikemedia-inct.streaming.media.azure.net/afcc5a99-d0c4-4ef5-9dfe-dc403a1269fb/learn-colors-with-numbers-in-kid.ism/manifest\(format=m3u8-aapl-v3\))

**Example:**

&#x20;         1\. sample\_video.mp4 -→ Mp4 video content.

&#x20;         2\. sample\_video.web → Web video content.

&#x20;         3\. streaming url --→ Streaming content.

\*\*Pons: \*\*

&#x20;     1.Will supports the old contents in the new version of the content-player (No contract break)

&#x20;     2\. Single version of videojs will bundled.

**Cons:**

1. Multiple extension checks are needed to support.

**Conclusion**

1. **LP Should migrate all older MP4 mimeType Contents previewURL to empty.**
2. **Sunbird mobile should show the "Preview" button only if previewURL is present.**
3. **Sunbird mobile**  app will send  following in content metadata to content playerFor streaming contents **previewUrl(if available) =** For locally downloaded contents **previewUrl=**
4. Sunbird mobile app will send  following in cData  &#x20;

```actionscript3
{
“id”: “<launch type>”, // offline/streaming
“type”: “PlayerLaunch"
}

```

1. **Content player will stream the mp4 content based on the config which is passed.**
2. **Need design from LP, What other video streaming metadata information is storing (Example: streamingType:"XXXX").**
3. **Sunbird mobile app**

\*\*CC:       \*\*

***

\[\[category.storage-team]] \[\[category.confluence]]
