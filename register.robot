*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url_web}    https://thermos.com/account/register

*** Test Cases ***
Regitrasi dengan data valid
    Open Browser    ${url_web}    Chrome
    Input Text    id=FirstName    Rangga Putra
    Input Text    id=Email    ranggaputra101@gmail.com
    Input Text    id=Phone    12345678910
    Input Text    name=customer[password]    Password1
    Input Text    name=customer[password_confirmation]    Password1
    Click Button    css=.btn-group.btn-wrap > button[type="submit"]
    Location Should Be    https://thermos.com/

Registrasi tanpa mengisi mandatory field
    Open Browser    ${url_web}     Chrome
    Click Button    css=.btn-group.btn-wrap > button[type="submit"]
    Wait Until Element Is Visible    css=.errors
    ${error_message}    Get Text    css=.errors
    Should Contain    ${error_message}    Password can't be blank.
    Should Contain    ${error_message}    Email can't be blank.

Registrasi dengan value yang berbeda pada field password dan confirm password
    Open Browser    ${url_web}     Chrome
    Input Text    id=FirstName    Rangga Putra
    Input Text    id=Email    ranggaputra@gmail.com
    Input Text    id=Phone    12345678910
    Input Text    name=customer[password]    Password1
    Input Text    name=customer[password_confirmation]    Password2
    Click Button    css=.btn-group.btn-wrap > button[type="submit"]
    Sleep    10s
    Alert Should Be Present     Passwords do not match.

Registrasi dengan value bukan email pada field email
    Open Browser    ${url_web}     Chrome
    Input Text    id=FirstName    Rangga Putra
    Input Text    id=Email    ranggaputra@gmail
    Input Text    id=Phone    12345678910
    Input Text    name=customer[password]    Password1
    Input Text    name=customer[password_confirmation]    Password1
    Click Button    css=.btn-group.btn-wrap > button[type="submit"]    
    Wait Until Element Is Visible    css=.errors
    ${error_message}    Get Text    css=.errors
    Should Contain    ${error_message}    Email is invalid.

Registrasi dengan akun yang sudah terdaftar
    Open Browser    ${url_web}    Chrome
    Input Text    id=FirstName    Rangga Putra
    Input Text    id=Email    ranggaputra101@gmail.com
    Input Text    id=Phone    12345678910
    Input Text    name=customer[password]    Password1
    Input Text    name=customer[password_confirmation]    Password1
    Click Button    css=.btn-group.btn-wrap > button[type="submit"]    
    Wait Until Element Is Visible    css=.errors
    ${error_message}    Get Text    css=.errors
    Should Contain    ${error_message}    This email address is already associated with an account. If this account is yours, you can reset your password