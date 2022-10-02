*** Settings ***
Documentation  These are some web tests
Resource  ../Resources/Web/Common.robot
Resource  ../Resources/Web/AmazonApp.robot
Test Setup  Common.Begin Web Test
Test Teardown  Common.End Web Test

*** Variables ***
${BROWSER} =  chrome
${START_URL} =  https://www.amazon.com
${SEARCH_TERM} =  Ferrari 458

*** Test Cases ***
Logged out user can search for products
    [Tags]  Web
    AmazonApp.Search for Products

Logged out user can add product to cart
    [Tags]  Web
    AmazonApp.Search for Products
    AmazonApp.Select Product from Search Results
    AmazonApp.Add Product to Cart
