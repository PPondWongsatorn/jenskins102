*** Settings ***
Documentation    API Testing for Simple API
Library          RequestsLibrary
Library          Collections
Resource         keywords.robot

*** Variables ***
${BASE_URL}      http://localhost:5000
${TIMEOUT}       10

*** Test Cases ***
Test Health Endpoint
    [Documentation]    Test the health check endpoint
    [Tags]            health
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /health
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal   ${json}[status]    healthy
    Delete All Sessions

Test Plus API With Positive Numbers
    [Documentation]    Test plus endpoint with positive numbers
    [Tags]            plus    positive
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /plus/5/6
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json}[result]    11
    Should Be Equal As Numbers    ${json}[num1]     5
    Should Be Equal As Numbers    ${json}[num2]     6
    Should Be Equal   ${json}[operation]    addition
    Delete All Sessions

Test Plus API With Negative Numbers
    [Documentation]    Test plus endpoint with negative numbers
    [Tags]            plus    negative
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /plus/-5/3
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json}[result]    -2
    Should Be Equal As Numbers    ${json}[num1]     -5
    Should Be Equal As Numbers    ${json}[num2]     3
    Delete All Sessions

Test Plus API With Zero
    [Documentation]    Test plus endpoint with zero
    [Tags]            plus    zero
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /plus/0/10
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json}[result]    10
    Should Be Equal As Numbers    ${json}[num1]     0
    Should Be Equal As Numbers    ${json}[num2]     10
    Delete All Sessions

Test Plus API With Large Numbers
    [Documentation]    Test plus endpoint with large numbers
    [Tags]            plus    large
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /plus/999/1
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json}[result]    1000
    Delete All Sessions

Test GetCode Endpoint
    [Documentation]    Test getcode endpoint returns valid response
    [Tags]            getcode
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /getcode
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Not Be Empty    ${json}[code]
    Should Not Be Empty    ${json}[message]
    Delete All Sessions

Test Plus API Response Format
    [Documentation]    Test plus endpoint response format is correct
    [Tags]            plus    format
    Create Session    api    ${BASE_URL}    timeout=${TIMEOUT}
    ${response}=      GET On Session    api    /plus/1/2
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    result
    Dictionary Should Contain Key    ${json}    num1
    Dictionary Should Contain Key    ${json}    num2
    Dictionary Should Contain Key    ${json}    operation
    Delete All Sessions

Test API Performance
    ${start}=    Evaluate    __import__('time').time()
    ${response}=    GET    ${BASE_URL}/plus/5/6
    ${end}=    Evaluate    __import__('time').time()
    ${response_time}=    Evaluate    ${end} - ${start}
    Should Be True    ${response_time} < 1.0