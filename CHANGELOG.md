# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Open]

### To Add

* Add configuration

### To Change

* Abort removing if an error has happened before

## [Unreleased]

### Added

### Changed

## [0.2.0](https://github.com/stevleibelt/windows_remove_old_users/tree/0.2.0) - released at 20210527

### Changed

* Changed output from `Write-Host` to `Write-Verbose`
* Do not ask removing if there is no user matching
* Implemented check if there is at least one fitting user found
* Reworked output of user list, previously it has happend that the output of the list was done after the removal

## [0.1.0](https://github.com/stevleibelt/windows_remove_old_users/tree/0.1.0) - released at 20210526

### Added

* Initial release
