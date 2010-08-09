Feature: Posting images

In order add posts with an image
As a user
I want to be able to add posts

@rack_test
Scenario: Moderating images on Houdini
  When I am on the homepage
  Then I should see "Pending (0)"
  And I should see "Aproved (0)"
  And I follow "New Post"
  Then I should see "New Post"
  When I fill in "Title" with "Edinborough"
  And I fill in "Body" with "Nice pic"
  And I fill in "Image url" with ""
  And I press "Save"
  Then I should see "Pending (1)"
  And I should see "Aproved (0)"
  And a request to houdini should be sent later

  When houdini posts back the answer:
    |subject_class | subject_id | task_name       | flagged |
    | post         | 1          | moderates_image | 'no'   |
  And I am on the homepage
  Then I should see "Pending (1)"
  And I should see "Aproved (0)"
