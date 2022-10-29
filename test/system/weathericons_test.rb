require "application_system_test_case"

class WeathericonsTest < ApplicationSystemTestCase
  setup do
    @weathericon = weathericons(:one)
  end

  test "visiting the index" do
    visit weathericons_url
    assert_selector "h1", text: "Weathericons"
  end

  test "creating a Weathericon" do
    visit weathericons_url
    click_on "New Weathericon"

    fill_in "Name", with: @weathericon.name
    click_on "Create Weathericon"

    assert_text "Weathericon was successfully created"
    click_on "Back"
  end

  test "updating a Weathericon" do
    visit weathericons_url
    click_on "Edit", match: :first

    fill_in "Name", with: @weathericon.name
    click_on "Update Weathericon"

    assert_text "Weathericon was successfully updated"
    click_on "Back"
  end

  test "destroying a Weathericon" do
    visit weathericons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weathericon was successfully destroyed"
  end
end
