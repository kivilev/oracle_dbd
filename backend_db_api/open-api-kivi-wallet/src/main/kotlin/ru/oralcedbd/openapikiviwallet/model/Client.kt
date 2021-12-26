package ru.oralcedbd.openapikiviwallet.model

import java.time.ZonedDateTime

data class Client(
    val id: Long?,
    val isActive: Int?,
    var createDtime: ZonedDateTime?,
    val firstName: String,
    val lastName: String,
    val middleName: String?,
    val email: String,
    val phone: String
)