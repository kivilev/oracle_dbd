package ru.oralcedbd.openapikiviwallet.dao

import java.sql.Timestamp
import java.time.ZoneId
import java.time.ZonedDateTime

object MapperUtils {

    fun convertDateToZonedDateTime(date: Timestamp): ZonedDateTime {
        return date.toLocalDateTime().atZone(ZoneId.systemDefault());
    }
}