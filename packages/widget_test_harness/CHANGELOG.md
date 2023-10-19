# 0.1.0+1

- feat: initial commit 🎉

# 0.1.0+2

- updated formating and fixes for pub scoring

# 0.2.0

- fixed some documentation
- Added http client in widget harness to mock NetworkImage

# 0.3.0

- added more documentation
- Updated how httpClient is created
- Updated how zones are handled

# 0.4.0

- updated harness creation

# 0.4.1

- fixed then functions calling themselves
- added fling to when

# 0.4.2
- add mixins
- updated reference to when in given

# 0.4.3
- reverted change

# 0.4.4
- Added parent class to given,when,then
- widgetTester now is added via new mechanism

# 0.5.0
- Added documentation
- Updated return types to make harness protected from being called directly
- Added better checking in harness to verify that things are setup correctly

# 0.5.1
- Added documentation
- Added then methods

# 0.6.0
- Updated to using dart 3 features

# 0.7.0
- Renamed dispose to teardown
- Made teardown a Future<void>

# 0.7.1
- Fixed not cleaning up when exception is thrown in test