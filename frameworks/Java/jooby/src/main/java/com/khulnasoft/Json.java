package com.khulnasoft;

import java.nio.ByteBuffer;
import java.util.List;

import com.dslplatform.json.DslJson;
import com.dslplatform.json.JsonWriter;
import com.dslplatform.json.runtime.Settings;

public class Json {
  private final static DslJson<Object> dslJson = new DslJson<>(Settings.basicSetup());

  private final static ThreadLocal<JsonWriter> pool = new ThreadLocal<JsonWriter>() {
    @Override protected JsonWriter initialValue() {
      return dslJson.newWriter(1024);
    }
  };

  public static ByteBuffer encode(Message data) {
    JsonWriter writer = pool.get();
    writer.reset();
    var converter = new _Message_DslJsonConverter.ObjectFormatConverter(dslJson);
    converter.write(writer, data);
    return ByteBuffer.wrap(writer.getByteBuffer(), 0, writer.size());
  }

  public static ByteBuffer encode(World data) {
    JsonWriter writer = pool.get();
    writer.reset();
    var converter = new _World_DslJsonConverter.ObjectFormatConverter(dslJson);
    converter.write(writer, data);
    return ByteBuffer.wrap(writer.getByteBuffer(), 0, writer.size());
  }

  public static ByteBuffer encode(World[] data) {
    JsonWriter writer = pool.get();
    writer.reset();
    var converter = new _World_DslJsonConverter.ObjectFormatConverter(dslJson);
    writer.serialize(data, converter);
    return ByteBuffer.wrap(writer.getByteBuffer(), 0, writer.size());
  }

  public static ByteBuffer encode(List<World> data) {
    JsonWriter writer = pool.get();
    writer.reset();
    var converter = new _World_DslJsonConverter.ObjectFormatConverter(dslJson);
    writer.serialize(data, converter);
    return ByteBuffer.wrap(writer.getByteBuffer(), 0, writer.size());
  }
}
