package ru.oralcedbd.openapikiviwallet.api.v1.models

import java.time.ZonedDateTime

data class ClientResponseDto(
    val id: Long?,
    val isActive: Boolean?,
    val createDateTime: ZonedDateTime?,
    val firstName: String,
    val lastName: String,
    val middleName: String?,
    val email: String,
    val phone: String
)