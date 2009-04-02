Feature: Ruby class visualization

  In order to improve my understand of a ruby class
  As a ruby developer
  I want to see a diagram of how class methods and variables collaborate

  Scenario Outline: Example ruby file
    Given a sample ruby file, <example>.rb
    When I execute "rubyviz <example>.rb"
    Then the expected output file "<example>.rb.png" should be produced
    
  Examples:
    | example  |
    | example1 |
    | example2 |
    | example3 |
    | example4 |
    | example5 |