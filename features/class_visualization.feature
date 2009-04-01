Feature: Ruby class visualization

  In order to improve my understand of a ruby class
  As a ruby developer
  I want to see a diagram of how class methods and variables collaborate

  Scenario: Simple file
    Given a sample ruby file, example1.rb
    When I execute "rubyviz example1.rb"
    Then the expect output file "example1.rb.png" should be produced
