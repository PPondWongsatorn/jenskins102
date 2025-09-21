*** Settings ***
Documentation    Common keywords for API testing
Library          RequestsLibrary
Library          DateTime

*** Keywords ***
Setup API Session
    [Arguments]    ${base_url}=${BASE_URL}
    Create Session    api    ${base_url}    timeout=10

Teardown API Session
    Delete All Sessions

Verify JSON Response Structure
    [Arguments]    ${response}    ${expected_keys}
    ${json}=       Set Variable    ${response.json()}
    FOR    ${key}    IN    @{expected_keys}
        Dictionary Should Contain Key    ${json}    ${key}
    END
    [Return]    ${json}

Test Plus Operation
    [Arguments]    ${num1}    ${num2}    ${expected_result}
    Setup API Session
    ${response}=      GET On Session    api    /plus/${num1}/${num2}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Should Be Equal As Numbers    ${json}[result]    ${expected_result}
    Teardown API Session