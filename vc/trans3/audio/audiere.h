/**
 * Audiere Sound System
 * Version 1.9.3
 * (c) 2001-2003 Chad Austin
 *
 * This API uses principles explained at
 * http://aegisknight.org/cppinterface.html
 *
 * This code licensed under the terms of the LGPL.  See doc/license.txt.
 *
 *
 * Note: When compiling this header in gcc, you may want to use the
 * -Wno-non-virtual-dtor flag to get rid of those annoying "class has
 * virtual functions but no virtual destructor" warnings.
 */

#ifndef AUDIERE_H
#define AUDIERE_H


#include <vector>
#include <string>

#ifdef _MSC_VER
#pragma warning(disable : 4786)
#endif


#ifndef __cplusplus
  #error Audiere requires C++
#endif


// DLLs in Windows should use the standard calling convention
#ifndef ADR_CALL
  #if defined(WIN32) || defined(_WIN32)
    #define ADR_CALL __stdcall
  #else
    #define ADR_CALL
  #endif
#endif

// Export functions from the DLL
#ifndef ADR_DECL
#  if defined(WIN32) || defined(_WIN32)
#    ifdef AUDIERE_EXPORTS
#      define ADR_DECL __declspec(dllexport)
#    else
#      define ADR_DECL __declspec(dllimport)
#    endif
#  else
#    define ADR_DECL
#  endif
#endif



#define ADR_FUNCTION(ret) extern "C" ADR_DECL ret ADR_CALL


namespace audiere {

  class RefCounted {
  protected:
    /**
     * Protected so users of refcounted classes don't use std::auto_ptr
     * or the delete operator.
     *
     * Interfaces that derive from RefCounted should define an inline,
     * empty, protected destructor as well.
     */
    ~RefCounted() { }

  public:
    /**
     * Add a reference to the internal reference count.
     */
    virtual void ADR_CALL ref() = 0;

    /**
     * Remove a reference from the internal reference count.  When this
     * reaches 0, the object is destroyed.
     */
    virtual void ADR_CALL unref() = 0;
  };


  template<typename T>
  class RefPtr {
  public:
    RefPtr(T* ptr = 0) {
      m_ptr = 0;
      *this = ptr;
    }

    RefPtr(const RefPtr<T>& ptr) {
      m_ptr = 0;
      *this = ptr;
    }

    ~RefPtr() {
      if (m_ptr) {
        m_ptr->unref();
        m_ptr = 0;
      }
    }
 
    RefPtr<T>& operator=(T* ptr) {
      if (ptr != m_ptr) {
        if (m_ptr) {
          m_ptr->unref();
        }
        m_ptr = ptr;
        if (m_ptr) {
          m_ptr->ref();
        }
      }
      return *this;
    }

    RefPtr<T>& operator=(const RefPtr<T>& ptr) {
      *this = ptr.m_ptr;
      return *this;
    }

    T* operator->() const {
      return m_ptr;
    }

    T& operator*() const {
      return *m_ptr;
    }

    operator bool() const {
      return (m_ptr != 0);
    }

    T* get() const {
      return m_ptr;
    }

  private:
    T* m_ptr;
  };


  /**
   * A basic implementation of the RefCounted interface.  Derive
   * your implementations from RefImplementation<YourInterface>.
   */
  template<class Interface>
  class RefImplementation : public Interface {
  protected:
    RefImplementation() {
      m_ref_count = 0;
    }

    /**
     * So the implementation can put its destruction logic in the destructor,
     * as natural C++ code does.
     */
    virtual ~RefImplementation() { }

  public:
    void ADR_CALL ref() {
      ++m_ref_count;
    }

    void ADR_CALL unref() {
      if (--m_ref_count == 0) {
        delete this;
      }
    }

  private:
    int m_ref_count;
  };


  /**
   * Represents a random-access file, usually stored on a disk.  Files
   * are always binary: that is, they do no end-of-line
   * transformations.  File objects are roughly analogous to ANSI C
   * FILE* objects.
   *
   * This interface is not synchronized.
   */
  class File : public RefCounted {
  protected:
    ~File() { }

  public:
    /**
     * The different ways you can seek within a file.
     */
    enum SeekMode {
      BEGIN,
      CURRENT,
      END,
    };

    /**
     * Read size bytes from the file, storing them in buffer.
     *
     * @param buffer  buffer to read into
     * @param size    number of bytes to read
     *
     * @return  number of bytes successfully read
     */
    virtual int ADR_CALL read(void* buffer, int size) = 0;

    /**
     * Jump to a new position in the file, using the specified seek
     * mode.  Remember: if mode is END, the position must be negative,
     * to seek backwards from the end of the file into its contents.
     * If the seek fails, the current position is undefined.
     *
     * @param position  position relative to the mode
     * @param mode      where to seek from in the file
     *
     * @return  true on success, false otherwise
     */
    virtual bool ADR_CALL seek(int position, SeekMode mode) = 0;

    /**
     * Get current position within the file.
     *
     * @return  current position
     */
    virtual int ADR_CALL tell() = 0;
  };
  typedef RefPtr<File> FilePtr;


  /// Storage formats for sample data.
  enum SampleFormat {
    SF_U8,  ///< unsigned 8-bit integer [0,255]
    SF_S16, ///< signed 16-bit integer in host endianness [-32768,32767]
  };


  /// Supported audio file formats.
  enum FileFormat {
    FF_AUTODETECT,
    FF_WAV,
    FF_OGG,
    FF_FLAC,
    FF_MP3,
    FF_MOD,
    FF_AIFF,
  };


  /**
   * Source of raw PCM samples.  Sample sources have an intrinsic format
   * (@see SampleFormat), sample rate, and number of channels.  They can
   * be read from or reset.
   *
   * Some sample sources are seekable.  Seekable sources have two additional
   * properties: length and position.  Length is read-only.
   *
   * This interface is not synchronized.
   */
  class SampleSource : public RefCounted {
  protected:
    ~SampleSource() { }

  public:
    /**
     * Retrieve the number of channels, sample rate, and sample format of
     * the sample source.
     */
    virtual void ADR_CALL getFormat(
      int& channel_count,
      int& sample_rate,
      SampleFormat& sample_format) = 0;

    /**
     * Read frame_count samples into buffer.  buffer must be at least
     * |frame_count * GetSampleSize(format) * channel_count| bytes long.
     *
     * @param frame_count  number of frames to read
     * @param buffer       buffer to store samples in
     *
     * @return  number of frames actually read
     */
    virtual int ADR_CALL read(int frame_count, void* buffer) = 0;

    /**
     * Reset the sample source.  This has the same effect as setPosition(0)
     * on a seekable source.  On an unseekable source, it resets all internal
     * state to the way it was when the source was first created.
     */
    virtual void ADR_CALL reset() = 0;

    /**
     * @return  true if the stream is seekable, false otherwise
     */
    virtual bool ADR_CALL isSeekable() = 0;

    /**
     * @return  number of frames in the stream, or 0 if the stream is not
     *          seekable
     */
    virtual int ADR_CALL getLength() = 0;
    
    /**
     * Sets the current position within the sample source.  If the stream
     * is not seekable, this method does nothing.
     *
     * @param position  current position in frames
     */
    virtual void ADR_CALL setPosition(int position) = 0;

    /**
     * Returns the current position within the sample source.
     *
     * @return  current position in frames
     */
    virtual int ADR_CALL getPosition() = 0;

    /**
     * @return  true if the sample source is set to repeat
     */
    virtual bool ADR_CALL getRepeat() = 0;

    /**
     * Sets whether the sample source should repeat or not.  Note that not
     * all sample sources repeat by starting again at the beginning of the
     * sound.  For example MOD files can contain embedded loop points.
     *
     * @param repeat  true if the source should repeat, false otherwise
     */
    virtual void ADR_CALL setRepeat(bool repeat) = 0;
  };
  typedef RefPtr<SampleSource> SampleSourcePtr;


  /**
   * LoopPointSource is a wrapper around another SampleSource, providing
   * custom loop behavior.  LoopPointSource maintains a set of links
   * within the sample stream and whenever the location of one of the links
   * (i.e. a loop point) is reached, the stream jumps to that link's target.
   * Each loop point maintains a count.  Every time a loop point comes into
   * effect, the count is decremented.  Once it reaches zero, that loop point
   * is temporarily disabled.  If a count is not a positive value, it
   * cannot be disabled.  Calling reset() resets all counts to their initial
   * values.
   *
   * Loop points only take effect when repeating has been enabled via the
   * setRepeat() method.
   *
   * Loop points are stored in sorted order by their location.  Each one
   * has an index based on its location within the list.  A loop point's
   * index will change if another is added before it.
   *
   * There is always one implicit loop point after the last sample that
   * points back to the first.  That way, this class's default looping
   * behavior is the same as a standard SampleSource.  This loop point
   * does not show up in the list.
   */
  class LoopPointSource : public SampleSource {
  protected:
    ~LoopPointSource() { }

  public:
    /**
     * Adds a loop point to the stream.  If a loop point at 'location'
     * already exists, the new one replaces it.  Location and target are
     * clamped to the actual length of the stream.
     *
     * @param location   frame where loop occurs
     * @param target     frame to jump to after loop point is hit
     * @param loopCount  number of times to execute this jump.
     */
    virtual void ADR_CALL addLoopPoint(
      int location, int target, int loopCount) = 0;

    /**
     * Removes the loop point at index 'index' from the stream.
     *
     * @param index  index of the loop point to remove
     */
    virtual void ADR_CALL removeLoopPoint(int index) = 0;

    /**
     * Returns the number of loop points in this stream.
     */
    virtual int ADR_CALL getLoopPointCount() = 0;

    /**
     * Retrieves information about a specific loop point.
     *
     * @param index      index of the loop point
     * @param location   frame where loop occurs
     * @param target     loop point's target frame
     * @param loopCount  number of times to loop from this particular point
     *
     * @return  true if the index is valid and information is returned
     */
    virtual bool ADR_CALL getLoopPoint(
      int index, int& location, int& target, int& loopCount) = 0;
  };
  typedef RefPtr<LoopPointSource> LoopPointSourcePtr;


  /**
   * A connection to an audio device.  Multiple output streams are
   * mixed by the audio device to produce the final waveform that the
   * user hears.
   *
   * Each output stream can be independently played and stopped.  They
   * also each have a volume from 0.0 (silence) to 1.0 (maximum volume).
   */
  class OutputStream : public RefCounted {
  protected:
    ~OutputStream() { }

  public:
    /**
     * Start playback of the output stream.  If the stream is already
     * playing, this does nothing.
     */
    virtual void ADR_CALL play() = 0;

    /**
     * Stop playback of the output stream.  If the stream is already
     * stopped, this does nothing.
     */
    virtual void ADR_CALL stop() = 0;

    /**
     * @return  true if the output stream is playing, false otherwise
     */
    virtual bool ADR_CALL isPlaying() = 0;

    /**
     * Reset the sample source or buffer to the beginning. On seekable
     * streams, this operation is equivalent to setPosition(0).
     *
     * On some output streams, this operation can be moderately slow, as up to
     * several seconds of PCM buffer must be refilled.
     */
    virtual void ADR_CALL reset() = 0;

    /**
     * Set whether the output stream should repeat.
     *
     * @param repeat  true if the stream should repeat, false otherwise
     */
    virtual void ADR_CALL setRepeat(bool repeat) = 0;

    /**
     * @return  true if the stream is repeating
     */
    virtual bool ADR_CALL getRepeat() = 0;

    /**
     * Sets the stream's volume.
     *
     * @param  volume  0.0 = silence, 1.0 = maximum volume (default)
     */
    virtual void ADR_CALL setVolume(float volume) = 0;

    /**
     * Gets the current volume.
     *
     * @return  current volume of the output stream
     */
    virtual float ADR_CALL getVolume() = 0;

    /**
     * Set current pan.
     *
     * @param pan  -1.0 = left, 0.0 = center (default), 1.0 = right
     */
    virtual void ADR_CALL setPan(float pan) = 0;

    /**
     * Get current pan.
     */
    virtual float ADR_CALL getPan() = 0;

    /**
     * Set current pitch shift.
     *
     * @param shift  can range from 0.5 to 2.0.  default is 1.0.
     */
    virtual void ADR_CALL setPitchShift(float shift) = 0;

    /**
     * Get current pitch shift.  Defaults to 1.0.
     */
    virtual float ADR_CALL getPitchShift() = 0;

    /**
     * @return  true if the stream is seekable, false otherwise
     */
    virtual bool ADR_CALL isSeekable() = 0;

    /**
     * @return  number of frames in the stream, or 0 if the stream is not
     *          seekable
     */
    virtual int ADR_CALL getLength() = 0;
    
    /**
     * Sets the current position within the sample source.  If the stream
     * is not seekable, this method does nothing.
     *
     * @param position  current position in frames
     */
    virtual void ADR_CALL setPosition(int position) = 0;

    /**
     * Returns the current position within the sample source.
     *
     * @return  current position in frames
     */
    virtual int ADR_CALL getPosition() = 0;
  };
  typedef RefPtr<OutputStream> OutputStreamPtr;


  /**
   * AudioDevice represents a device on the system which is capable
   * of opening and mixing multiple output streams.  In Windows,
   * DirectSound is such a device.
   *
   * This interface is synchronized.  update() and openStream() may
   * be called on different threads.
   */
  class AudioDevice : public RefCounted {
  protected:
    ~AudioDevice() { }

  public:
    /**
     * Tell the device to do any internal state updates.  Some devices
     * update on an internal thread.  If that is the case, this method
     * does nothing.
     */
    virtual void ADR_CALL update() = 0;

    /**
     * Open an output stream with a given sample source.  If the sample
     * source ever runs out of data, the output stream automatically stops
     * itself.
     *
     * The output stream takes ownership of the sample source, even if
     * opening the output stream fails (in which case the source is
     * immediately deleted).
     *
     * @param  source  the source used to feed the output stream with samples
     *
     * @return  new output stream if successful, 0 if failure
     */
    virtual OutputStream* ADR_CALL openStream(SampleSource* source) = 0;

    /**
     * Open a single buffer with the specified PCM data.  This is sometimes
     * more efficient than streaming and works on a larger variety of audio
     * devices.  In some implementations, this may download the audio data
     * to the sound card's memory itself.
     *
     * @param samples  Buffer containing sample data.  openBuffer() does
     *                 not take ownership of the memory.  The application
     *                 is responsible for freeing it.  There must be at
     *                 least |frame_count * channel_count *
     *                 GetSampleSize(sample_format)| bytes in the buffer.
     *
     * @param frame_count  Number of frames in the buffer.
     *
     * @param channel_count  Number of audio channels.  1 = mono, 2 = stereo.
     *
     * @param sample_rate  Number of samples per second.
     *
     * @param sample_format  Format of samples in buffer.
     *
     * @return  new output stream if successful, 0 if failure
     */
    virtual OutputStream* ADR_CALL openBuffer(
      void* samples,
      int frame_count,
      int channel_count,
      int sample_rate,
      SampleFormat sample_format) = 0;

    /**
     * Gets the name of the audio device.  For example "directsound" or "oss".
     *
     * @return name of audio device
     */
    virtual const char* ADR_CALL getName() = 0;
  };
  typedef RefPtr<AudioDevice> AudioDevicePtr;


  /**
   * A readonly sample container which can open sample streams as iterators
   * through the buffer.  This is commonly used in cases where a very large
   * sound effect is loaded once into memory and then streamed several times
   * to the audio device.  This is more efficient memory-wise than loading
   * the effect multiple times.
   *
   * @see CreateSampleBuffer
   */
  class SampleBuffer : public RefCounted {
  protected:
    ~SampleBuffer() { }

  public:

    /**
     * Return the format of the sample data in the sample buffer.
     * @see SampleSource::getFormat
     */
    virtual void ADR_CALL getFormat(
      int& channel_count,
      int& sample_rate,
      SampleFormat& sample_format) = 0;

    /**
     * Get the length of the sample buffer in frames.
     */
    virtual int ADR_CALL getLength() = 0;

    /**
     * Get a readonly pointer to the samples contained within the buffer.  The
     * buffer is |channel_count * frame_count * GetSampleSize(sample_format)|
     * bytes long.
     */
    virtual const void* ADR_CALL getSamples() = 0;

    /**
     * Open a seekable sample source using the samples contained in the
     * buffer.
     */
    virtual SampleSource* ADR_CALL openStream() = 0;
  };
  typedef RefPtr<SampleBuffer> SampleBufferPtr;


  /**
   * Defines the type of SoundEffect objects.  @see SoundEffect
   */
  enum SoundEffectType {
    SINGLE,
    MULTIPLE,
  };


  /**
   * SoundEffect is a convenience class which provides a simple
   * mechanism for basic sound playback.  There are two types of sound
   * effects: SINGLE and MULTIPLE.  SINGLE sound effects only allow
   * the sound to be played once at a time.  MULTIPLE sound effects
   * always open a new stream to the audio device for each time it is
   * played (cleaning up or reusing old streams if possible).
   */
  class SoundEffect : public RefCounted {
  protected:
    ~SoundEffect() { }

  public:
    /**
     * Trigger playback of the sound.  If the SoundEffect is of type
     * SINGLE, this plays the sound if it isn't playing yet, and
     * starts it again if it is.  If the SoundEffect is of type
     * MULTIPLE, play() simply starts playing the sound again.
     */
    virtual void ADR_CALL play() = 0;

    /**
     * If the sound is of type SINGLE, stop the sound.  If it is of
     * type MULTIPLE, stop all playing instances of the sound.
     */
    virtual void ADR_CALL stop() = 0;

    /**
     * Sets the sound's volume.
     *
     * @param  volume  0.0 = silence, 1.0 = maximum volume (default)
     */
    virtual void ADR_CALL setVolume(float volume) = 0;

    /**
     * Gets the current volume.
     *
     * @return  current volume of the output stream
     */
    virtual float ADR_CALL getVolume() = 0;

    /**
     * Set current pan.
     *
     * @param pan  -1.0 = left, 0.0 = center (default), 1.0 = right
     */
    virtual void ADR_CALL setPan(float pan) = 0;

    /**
     * Get current pan.
     */
    virtual float ADR_CALL getPan() = 0;

    /**
     * Set current pitch shift.
     *
     * @param shift  can range from 0.5 to 2.0.  default is 1.0.
     */
    virtual void ADR_CALL setPitchShift(float shift) = 0;

    /**
     * Get current pitch shift.  Defaults to 1.0.
     */
    virtual float ADR_CALL getPitchShift() = 0;
  };
  typedef RefPtr<SoundEffect> SoundEffectPtr;


  /// PRIVATE API - for internal use only
  namespace hidden {

    // these are extern "C" so we don't mangle the names

    ADR_FUNCTION(const char*) AdrGetVersion();

    /**
     * Returns a formatted string that lists the file formats that Audiere
     * supports.  This function is DLL-safe.
     *
     * It is formatted in the following way:
     *
     * description1:ext1,ext2,ext3;description2:ext1,ext2,ext3
     */
    ADR_FUNCTION(const char*) AdrGetSupportedFileFormats();

    /**
     * Returns a formatted string that lists the audio devices Audiere
     * supports.  This function is DLL-safe.
     *
     * It is formatted in the following way:
     *
     * name1:description1;name2:description2;...
     */
    ADR_FUNCTION(const char*) AdrGetSupportedAudioDevices();

    ADR_FUNCTION(int) AdrGetSampleSize(SampleFormat format);

    ADR_FUNCTION(AudioDevice*) AdrOpenDevice(
      const char* name,
      const char* parameters);

    ADR_FUNCTION(SampleSource*) AdrOpenSampleSource(
      const char* filename,
      FileFormat file_format);
    ADR_FUNCTION(SampleSource*) AdrOpenSampleSourceFromFile(
      File* file,
      FileFormat file_format);
    ADR_FUNCTION(SampleSource*) AdrCreateTone(double frequency);
    ADR_FUNCTION(SampleSource*) AdrCreateSquareWave(double frequency);
    ADR_FUNCTION(SampleSource*) AdrCreateWhiteNoise();
    ADR_FUNCTION(SampleSource*) AdrCreatePinkNoise();

    ADR_FUNCTION(LoopPointSource*) AdrCreateLoopPointSource(
      SampleSource* source);

    ADR_FUNCTION(OutputStream*) AdrOpenSound(
      AudioDevice* device,
      SampleSource* source,
      bool streaming);

    ADR_FUNCTION(SampleBuffer*) AdrCreateSampleBuffer(
      void* samples,
      int frame_count,
      int channel_count,
      int sample_rate,
      SampleFormat sample_format);
    ADR_FUNCTION(SampleBuffer*) AdrCreateSampleBufferFromSource(
      SampleSource* source);

    ADR_FUNCTION(SoundEffect*) AdrOpenSoundEffect(
      AudioDevice* device,
      SampleSource* source,
      SoundEffectType type);

    ADR_FUNCTION(File*) AdrOpenFile(
      const char* name,
      bool writeable);

    ADR_FUNCTION(File*) AdrCreateMemoryFile(
      const void* buffer,
      int size);
  }


  /* PUBLIC API */


  /**
   * Returns the Audiere version string.
   *
   * @return  Audiere version information
   */
  inline const char* GetVersion() {
    return hidden::AdrGetVersion();
  }


  inline void SplitString(
    std::vector<std::string>& out,
    const char* in,
    char delim)
  {
    out.clear();
    while (*in) {
      const char* next = strchr(in, delim);
      if (next) {
        out.push_back(std::string(in, next));
      } else {
        out.push_back(in);
      }

      in = (next ? next + 1 : "");
    }
  }


  /// Describes a file format that Audiere supports.
  struct FileFormatDesc {
    /// Short description of format, such as "MP3 Files" or "Mod Files"
    std::string description;

    /// List of support extensions, such as {"mod", "it", "xm"}
    std::vector<std::string> extensions;
  };

  /// Populates a vector of FileFormatDesc structs.
  inline void GetSupportedFileFormats(std::vector<FileFormatDesc>& formats) {
    std::vector<std::string> descriptions;
    SplitString(descriptions, hidden::AdrGetSupportedFileFormats(), ';');

    formats.resize(descriptions.size());
    for (unsigned i = 0; i < descriptions.size(); ++i) {
      const char* d = descriptions[i].c_str();
      const char* colon = strchr(d, ':');
      formats[i].description.assign(d, colon);

      SplitString(formats[i].extensions, colon + 1, ',');
    }
  }


  /// Describes a supported audio device.
  struct AudioDeviceDesc {
    /// Name of device, i.e. "directsound", "winmm", or "oss"
    std::string name;

    // Textual description of device.
    std::string description;
  };

  /// Populates a vector of AudioDeviceDesc structs.
  inline void GetSupportedAudioDevices(std::vector<AudioDeviceDesc>& devices) {
    std::vector<std::string> descriptions;
    SplitString(descriptions, hidden::AdrGetSupportedAudioDevices(), ';');

    devices.resize(descriptions.size());
    for (unsigned i = 0; i < descriptions.size(); ++i) {
      std::vector<std::string> d;
      SplitString(d, descriptions[i].c_str(), ':');
      devices[i].name        = d[0];
      devices[i].description = d[1];
    }
  }


  /**
   * Get the size of a sample in a specific sample format.
   * This is commonly used to determine how many bytes a chunk of
   * PCM data will take.
   *
   * @return  Number of bytes a single sample in the specified format
   *          takes.
   */
  inline int GetSampleSize(SampleFormat format) {
    return hidden::AdrGetSampleSize(format);
  }

  /**
   * Open a new audio device. If name or parameters are not specified,
   * defaults are used. Each platform has its own set of audio devices.
   * Every platform supports the "null" audio device.
   *
   * @param  name  name of audio device that should be used
   * @param  parameters  comma delimited list of audio-device parameters;
   *                     for example, "buffer=100,rate=44100"
   *
   * @return  new audio device object if OpenDevice succeeds, and 0 in case
   *          of failure
   */
  inline AudioDevice* OpenDevice(
    const char* name = 0,
    const char* parameters = 0)
  {
    return hidden::AdrOpenDevice(name, parameters);
  }

  /**
   * Create a streaming sample source from a sound file.  This factory simply
   * opens a default file from the system filesystem and calls
   * OpenSampleSource(File*).
   *
   * @see OpenSampleSource(File*)
   */
  inline SampleSource* OpenSampleSource(
    const char* filename,
    FileFormat file_format = FF_AUTODETECT)
  {
    return hidden::AdrOpenSampleSource(filename, file_format);
  }

  /**
   * Opens a sample source from the specified file object.  If the sound file
   * cannot be opened, this factory function returns 0.
   *
   * @note  Some sound files support seeking, while some don't.
   *
   * @param file         File object from which to open the decoder
   * @param file_format  Format of the file to load.  If FF_AUTODETECT,
   *                     Audiere will try opening the file in each format.
   *
   * @return  new SampleSource if OpenSampleSource succeeds, 0 otherwise
   */
  inline SampleSource* OpenSampleSource(
    const FilePtr& file,
    FileFormat file_format = FF_AUTODETECT)
  {
    return hidden::AdrOpenSampleSourceFromFile(file.get(), file_format);
  }

  /**
   * Create a tone sample source with the specified frequency.
   *
   * @param  frequency  Frequency of the tone in Hz.
   *
   * @return  tone sample source
   */
  inline SampleSource* CreateTone(double frequency) {
    return hidden::AdrCreateTone(frequency);
  }

  /**
   * Create a square wave with the specified frequency.
   *
   * @param  frequency  Frequency of the wave in Hz.
   *
   * @return  wave sample source
   */
  inline SampleSource* CreateSquareWave(double frequency) {
    return hidden::AdrCreateSquareWave(frequency);
  }

  /**
   * Create a white noise sample source.  White noise is just random
   * data.
   *
   * @return  white noise sample source
   */
  inline SampleSource* CreateWhiteNoise() {
    return hidden::AdrCreateWhiteNoise();
  }

  /**
   * Create a pink noise sample source.  Pink noise is noise with equal
   * power distribution among octaves (logarithmic), not frequencies.
   *
   * @return  pink noise sample source
   */
  inline SampleSource* CreatePinkNoise() {
    return hidden::AdrCreatePinkNoise();
  }

  /**
   * Create a LoopPointSource from a SampleSource.  The SampleSource must
   * be seekable.  If it isn't, or the source isn't valid, this function
   * returns 0.
   */
  inline LoopPointSource* CreateLoopPointSource(
    const SampleSourcePtr& source)
  {
    return hidden::AdrCreateLoopPointSource(source.get());
  }

  /**
   * Creates a LoopPointSource from a source loaded from a file.
   */
  inline LoopPointSource* CreateLoopPointSource(
    const char* filename,
    FileFormat file_format = FF_AUTODETECT)
  {
    return CreateLoopPointSource(OpenSampleSource(filename, file_format));
  }

  /**
   * Creates a LoopPointSource from a source loaded from a file.
   */
  inline LoopPointSource* CreateLoopPointSource(
    const FilePtr& file,
    FileFormat file_format = FF_AUTODETECT)
  {
    return CreateLoopPointSource(OpenSampleSource(file, file_format));
  }

  /**
   * Try to open a sound buffer using the specified AudioDevice and
   * sample source.  If the specified sample source is seekable, it
   * loads it into memory and uses AudioDevice::openBuffer to create
   * the output stream.  If the stream is not seekable, it uses
   * AudioDevice::openStream to create the output stream.  This means
   * that certain file types must always be streamed, and therefore,
   * OpenSound will hold on to the file object.  If you must guarantee
   * that the file on disk is no longer referenced, you must create
   * your own memory file implementation and load your data into that
   * before calling OpenSound.
   *
   * @param device  AudioDevice in which to open the output stream.
   *
   * @param source  SampleSource used to generate samples for the sound
   *                object.  OpenSound takes ownership of source, even
   *                if it returns 0.  (In that case, OpenSound immediately
   *                deletes the SampleSource.)
   *
   * @param streaming  If false or unspecified, OpenSound attempts to
   *                   open the entire sound into memory.  Otherwise, it
   *                   streams the sound from the file.
   *
   * @return  new output stream if successful, 0 otherwise
   */
  inline OutputStream* OpenSound(
    const AudioDevicePtr& device,
    const SampleSourcePtr& source,
    bool streaming = false)
  {
    return hidden::AdrOpenSound(device.get(), source.get(), streaming);
  }

  /**
   * Calls OpenSound(AudioDevice*, SampleSource*) with a sample source
   * created via OpenSampleSource(const char*).
   */
  inline OutputStream* OpenSound(
    const AudioDevicePtr& device,
    const char* filename,
    bool streaming = false,
    FileFormat file_format = FF_AUTODETECT)
  {
    SampleSource* source = OpenSampleSource(filename, file_format);
    return OpenSound(device, source, streaming);
  }

  /**
   * Calls OpenSound(AudioDevice*, SampleSource*) with a sample source
   * created via OpenSampleSource(File* file).
   */
  inline OutputStream* OpenSound(
    const AudioDevicePtr& device,
    const FilePtr& file,
    bool streaming = false,
    FileFormat file_format = FF_AUTODETECT)
  {
    SampleSource* source = OpenSampleSource(file, file_format);
    return OpenSound(device, source, streaming);
  }

  /**
   * Create a SampleBuffer object using the specified samples and formats.
   *
   * @param samples  Pointer to a buffer of samples used to initialize the
   *                 new object.  If this is 0, the sample buffer contains
   *                 just silence.
   *
   * @param frame_count  Size of the sample buffer in frames.
   *
   * @param channel_count  Number of channels in each frame.
   *
   * @param sample_rate  Sample rate in Hz.
   *
   * @param sample_format  Format of each sample.  @see SampleFormat.
   *
   * @return  new SampleBuffer object
   */
  inline SampleBuffer* CreateSampleBuffer(
    void* samples,
    int frame_count,
    int channel_count,
    int sample_rate,
    SampleFormat sample_format)
  {
    return hidden::AdrCreateSampleBuffer(
      samples, frame_count,
      channel_count, sample_rate, sample_format);
  }

  /**
   * Create a SampleBuffer object from a SampleSource.
   *
   * @param source  Seekable sample source used to create the buffer.
   *                If the source is not seekable, then the function
   *                fails.
   *
   * @return  new sample buffer if success, 0 otherwise
   */
  inline SampleBuffer* CreateSampleBuffer(const SampleSourcePtr& source) {
    return hidden::AdrCreateSampleBufferFromSource(source.get());
  }

  /**
   * Open a SoundEffect object from the given sample source and sound
   * effect type.  @see SoundEffect
   *
   * @param device  AudioDevice on which the sound is played.
   *
   * @param source  The sample source used to feed the sound effect
   *                with data.
   *
   * @param type  The type of the sound effect.  If type is MULTIPLE,
   *              the source must be seekable.
   *
   * @return  new SoundEffect object if successful, 0 otherwise
   */
  inline SoundEffect* OpenSoundEffect(
    const AudioDevicePtr& device,
    const SampleSourcePtr& source,
    SoundEffectType type)
  {
    return hidden::AdrOpenSoundEffect(device.get(), source.get(), type);
  }

  /**
   * Calls OpenSoundEffect(AudioDevice*, SampleSource*,
   * SoundEffectType) with a sample source created from the filename.
   */
  inline SoundEffect* OpenSoundEffect(
    const AudioDevicePtr& device,
    const char* filename,
    SoundEffectType type,
    FileFormat file_format = FF_AUTODETECT)
  {
    SampleSource* source = OpenSampleSource(filename, file_format);
    return OpenSoundEffect(device, source, type);
  }

  /**
   * Calls OpenSoundEffect(AudioDevice*, SampleSource*,
   * SoundEffectType) with a sample source created from the file.
   */
  inline SoundEffect* OpenSoundEffect(
    const AudioDevicePtr& device,
    const FilePtr& file,
    SoundEffectType type,
    FileFormat file_format = FF_AUTODETECT)
  {
    SampleSource* source = OpenSampleSource(file, file_format);
    return OpenSoundEffect(device, source, type);
  }

  /**
   * Opens a default file implementation from the local filesystem.
   *
   * @param filename   The name of the file on the local filesystem.
   * @param writeable  Whether the writing to the file is allowed.
   */
  inline File* OpenFile(const char* filename, bool writeable) {
    return hidden::AdrOpenFile(filename, writeable);
  }

  /**
   * Creates a File implementation that reads from a buffer in memory.
   * It stores a copy of the buffer that is passed in.
   *
   * The File object does <i>not</i> take ownership of the memory buffer.
   * When the file is destroyed, it will not free the memory.
   *
   * @param buffer  Pointer to the beginning of the data.
   * @param size    Size of the buffer in bytes.
   *
   * @return  0 if size is non-zero and buffer is null. Otherwise,
   *          returns a valid File object.
   */
  inline File* CreateMemoryFile(const void* buffer, int size) {
    return hidden::AdrCreateMemoryFile(buffer, size);
  }
    
}


#endif
