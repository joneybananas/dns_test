package com.example.dnstest.dns_test
import kotlinx.serialization.KSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import java.util.Date

@Serializable
enum class TaskStatus {
 open,
 inProgress,
 done;
}

@Serializable
data class Task(
 val id: String,
 val name: String,
 val description: String,
 @Serializable(with = TaskStatusSerializer::class)
 val taskStatus: TaskStatus,
 @Serializable(with = DateSerializer::class)
 val creationDate: Date
) {
 object DateSerializer : KSerializer<Date> {
  override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("Date", PrimitiveKind.LONG)

  override fun serialize(encoder: Encoder, value: Date) {
   encoder.encodeLong(value.time)
  }

  override fun deserialize(decoder: Decoder): Date {
   return Date(decoder.decodeLong())
  }
 }

 object TaskStatusSerializer : KSerializer<TaskStatus> {
  override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("TaskStatus", PrimitiveKind.INT)

  override fun serialize(encoder: Encoder, value: TaskStatus) {
   encoder.encodeInt(value.ordinal)
  }

  override fun deserialize(decoder: Decoder): TaskStatus {
   val index = decoder.decodeInt()
   return TaskStatus.values().getOrElse(index) {
    throw SerializationException("Unknown index for TaskStatus: $index")
   }
  }
 }
}