*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Verify Page Loaded
    Wait Until Page Contains  Back to results

Add to Cart
    Click Element  id=mbc-buybutton-addtocart-2