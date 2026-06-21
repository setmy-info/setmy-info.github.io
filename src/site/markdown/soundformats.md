# Sound formats

## Information

Audio file formats are divided into two broad categories: **lossless** and **lossy**.

* **Lossless** formats preserve all original audio data. Re-encoding a lossless file produces a bit-for-bit identical
  result. Suitable for archiving, professional production, and situations where quality must not degrade.
* **Lossy** formats discard audio data that is considered perceptually inaudible, achieving much smaller file sizes at
  the cost of irreversible quality loss. Each re-encode of a lossy file degrades quality further.

### Common audio formats

| Format        | Type    | Container | Notes                                                             |
|---------------|---------|-----------|-------------------------------------------------------------------|
| FLAC          | Lossless | .flac    | Free Lossless Audio Codec. Open standard. Widely supported.       |
| WAV           | Lossless | .wav     | Uncompressed PCM. Large files. Universal support.                 |
| AIFF          | Lossless | .aiff    | Apple equivalent of WAV. Uncompressed PCM.                        |
| ALAC          | Lossless | .m4a     | Apple Lossless Audio Codec. Inside MP4 container.                 |
| MP3           | Lossy   | .mp3     | MPEG-1 Audio Layer III. Ubiquitous. Patent-expired.               |
| AAC           | Lossy   | .m4a/.aac| Advanced Audio Coding. Better quality than MP3 at same bitrate.   |
| OGG Vorbis    | Lossy   | .ogg     | Open standard lossy codec. Good quality-to-size ratio.            |
| Opus          | Lossy   | .opus    | Modern open codec. Excellent at low bitrates. Preferred for VoIP. |
| WMA           | Lossy   | .wma     | Windows Media Audio. Microsoft proprietary.                       |

### Container vs codec

A **codec** defines how audio data is encoded/decoded (e.g., FLAC, MP3, Vorbis). A **container** is the file format
that wraps the encoded stream along with metadata (e.g., `.ogg` wraps Vorbis; `.m4a` wraps AAC or ALAC). The
container and codec are not always the same thing.

### Typical bitrate guidance (lossy)

| Quality level | MP3        | AAC        | Opus       |
|---------------|------------|------------|------------|
| Low           | 64–96 kbps | 48–80 kbps | 32–48 kbps |
| Standard      | 128 kbps   | 96–128 kbps| 64–96 kbps |
| High          | 192 kbps   | 160 kbps   | 128 kbps   |
| Transparent   | 320 kbps   | 256 kbps   | 160 kbps   |

## Usage, tips and tricks

### Convert formats with ffmpeg

```shell
# WAV to FLAC (lossless)
ffmpeg -i input.wav output.flac

# FLAC to MP3 at 192 kbps
ffmpeg -i input.flac -b:a 192k output.mp3

# Any format to Opus at 96 kbps
ffmpeg -i input.wav -c:a libopus -b:a 96k output.opus

# Batch convert a directory of FLAC to MP3
for f in *.flac; do ffmpeg -i "$f" -b:a 192k "${f%.flac}.mp3"; done
```

### Inspect audio file metadata

```shell
ffprobe -v quiet -print_format json -show_format input.flac
```

### SoX (Sound eXchange)

SoX is a command-line audio processing tool:

```shell
# Convert sample rate
sox input.wav -r 44100 output.wav

# Normalize audio
sox input.wav output.wav norm
```

## See also

* [ffmpeg audio documentation](https://ffmpeg.org/ffmpeg-codecs.html#Audio-Encoders)
* [FLAC format specification](https://xiph.org/flac/)
* [Opus codec](https://opus-codec.org/)
* [SoX - Sound eXchange](http://sox.sourceforge.net/)
* [Audacity audio editor](audacity.md)
