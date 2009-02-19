Feature: Import remote repository
  In order to speed up deployments and to only deploy code that's been tested tested
  A developer
  Wants to import remote repositories
  So that he is protected from inadvertent updates

  Scenario: Importing from a Subversion repository
    Given a newly created Subversion project
    And a remote Subversion project named libcalc
    And a file named libcalc.rb with content "a\nb\nc" in remote libcalc project
    When I import libcalc
    Then I should see "Imported revision \d+ from .*/libcalc"
    Then I should find a libcalc folder
    Then I should find a libcalc/libcalc.rb file
    Then I should find a libcalc/.piston.yml file

  Scenario: Importing from a classic Subversion project layout automatically uses project's name and not trunk for the local folder name
    Given a newly created Subversion project
    And a remote Subversion project named libcalc using the classic layout
    And a file named libcalc.rb with content "a\nb\nc" in remote libcalc project
    When I import libcalc/trunk
    Then I should see "Imported revision \d+ from .*/libcalc"
    Then I should find a libcalc folder
    Then I should find a libcalc/libcalc.rb file
    Then I should find a libcalc/.piston.yml file

  Scenario: Importing into a specific folder bails if the parent folders doesn't exist
    Given a newly created Subversion project
    And a remote Subversion project named libcalc using the classic layout
    And a file named libcalc.rb with content "a\nb\nc" in remote libcalc project
    When I import libcalc/trunk into vendor/libcalc
    Then I should see "Folder .*/vendor/libcalc could not be created.  Is .*/vendor a working copy\? \(Tip: svn mkdir it\)"
    Then I should not find a vendor/libcalc folder
