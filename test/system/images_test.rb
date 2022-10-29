require "application_system_test_case"

class ImagesTest < ApplicationSystemTestCase
  setup do
    @image = images(:one)
  end

  test "visiting the index" do
    visit images_url
    assert_selector "h1", text: "Images"
  end

  test "creating a Image" do
    visit images_url
    click_on "New Image"

    fill_in "Addres", with: @image.addres
    fill_in "Altitude", with: @image.altitude
    fill_in "Comment", with: @image.comment
    fill_in "Compass value", with: @image.compass_value
    fill_in "Icon", with: @image.icon
    fill_in "Latitude", with: @image.latitude
    fill_in "Longitude", with: @image.longitude
    fill_in "User", with: @image.user_id
    click_on "Create Image"

    assert_text "Image was successfully created"
    click_on "Back"
  end

  test "updating a Image" do
    visit images_url
    click_on "Edit", match: :first

    fill_in "Addres", with: @image.addres
    fill_in "Altitude", with: @image.altitude
    fill_in "Comment", with: @image.comment
    fill_in "Compass value", with: @image.compass_value
    fill_in "Icon", with: @image.icon
    fill_in "Latitude", with: @image.latitude
    fill_in "Longitude", with: @image.longitude
    fill_in "User", with: @image.user_id
    click_on "Update Image"

    assert_text "Image was successfully updated"
    click_on "Back"
  end

  test "destroying a Image" do
    visit images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Image was successfully destroyed"
  end
end
