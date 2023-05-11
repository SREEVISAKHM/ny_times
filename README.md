# ny_times

Flutter Project for fetching newyork times most popular articles

## Getting Started

1.Clone this repository to your local machine:
https://github.com/SREEVISAKHM/ny_times.git

2.Install the required dependencies:
flutter pub get

3.Run the app:
flutter run

## Running the tests

1.change to the project test directory

2.Run the test
flutter test

## Generating Coverage report

1.Generate the coverage report:
flutter test --coverage

2.View the coverage report
flutter pub run coverage:format_coverage --lcov --in=coverage/lcov.info --out=coverage/report.txt --packages=.packages --report-on=lib
