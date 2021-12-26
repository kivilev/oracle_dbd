package ru.oralcedbd.openapikiviwallet.api.v1.models

data class ClientCreateRequestDto(
    val firstName: String,
    val lastName: String,
    val middleName: String?,
    val email: String,
    val phone: String
)