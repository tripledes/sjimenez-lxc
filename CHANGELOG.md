Thu Jan 1 01:32:48 2015 +0100 :fireworks: Happy 2015!
Tue Dec 30 15:37:16 2014 +0100 Updated metadata.json.
Tue Dec 30 15:37:02 2014 +0100 Updated README
Sun Dec 28 13:06:25 2014 +0100 More tests.
Sun Dec 28 13:03:46 2014 +0100 Refactored lxc_interface type.
Sun Dec 28 13:03:13 2014 +0100 Added value validation to timeout and template params
Sun Dec 28 13:00:55 2014 +0100 Made #define_container private
Sun Dec 28 12:58:50 2014 +0100 Added tests for setters.
Sun Dec 28 12:56:01 2014 +0100 Refactored lxc provider.
Fri Dec 26 23:18:42 2014 +0100 Moved container instantiation to its own private method.
Fri Dec 26 22:36:24 2014 +0100 More acceptance tests
Fri Dec 26 18:46:35 2014 +0100 Added and reorganized rspec-puppet tests
Fri Dec 26 17:48:49 2014 +0100 Switched to stdlib private() function
Fri Dec 26 17:36:31 2014 +0100 Removed restart param from lxc resource
Fri Dec 26 17:28:53 2014 +0100 make template default to ubuntu
Fri Dec 26 17:27:50 2014 +0100 Added/improved headers.
Fri Dec 26 16:45:05 2014 +0100 More class documentation
Fri Dec 26 16:44:33 2014 +0100 booleans as symbols, consistency
Fri Dec 26 01:27:08 2014 +0100 Added ipv4_gateway to lxc_interface
Fri Dec 26 01:17:43 2014 +0100 Added ipv4_gateway property
Thu Dec 25 20:10:43 2014 +0100 Reverted addition of Ruby 1.8.7 to Travis
Thu Dec 25 20:08:12 2014 +0100 Added 1.8.7 to Travis matrix
Thu Dec 25 20:03:39 2014 +0100 Fix for Ruby 1.8.
Thu Dec 25 20:01:48 2014 +0100 Execute Puppet 3 times on precise.
Thu Dec 25 20:00:15 2014 +0100 Use puppetlabs precise box with puppet included.
Thu Dec 25 16:19:00 2014 +0100 Converted subclasses to private.
Mon Dec 22 19:26:08 2014 +0100 Switched vagrant image with puppet included
Mon Dec 22 19:23:08 2014 +0100 Added class lxc::networking::containers.
Sun Dec 21 23:30:10 2014 +0100 Updated README
Sun Dec 21 23:29:50 2014 +0100 Test autostart value
Sun Dec 21 23:26:26 2014 +0100 Finished autostart and related settings.
Sat Dec 20 22:42:59 2014 +0100 Added autostart features to lxc provider.
Sat Dec 20 22:41:24 2014 +0100 Changed autostart_group to groups
Sat Dec 20 14:28:37 2014 +0100 Added autostart features to lxc type.
Tue Dec 16 01:46:35 2014 +0100 Allow to configure first interface.
Mon Dec 15 16:52:58 2014 +0100 Removed networking from lxc type.
Sun Dec 14 21:00:39 2014 +0100 Added template_options to acceptance tests.
Sun Dec 14 20:58:46 2014 +0100 Tried to overcome the ruby1.8 issue on Precise.
Sun Dec 14 20:57:13 2014 +0100 Make sure rubygems is there when on Precise.
Sun Dec 14 20:55:21 2014 +0100 Mods on beaker's nodes.
Sun Dec 14 20:52:56 2014 +0100 Different list of packages for Trusty or Precise.
Sun Dec 14 20:49:28 2014 +0100 Added template_options parameter to lxc type.
Sun Dec 14 20:46:48 2014 +0100 Upgreded gems.
Fri Dec 12 18:07:22 2014 +0100 Added basic acceptance tests, beaker-rspec
Fri Dec 12 11:49:31 2014 +0100 Added support for Ubuntu Precise.
Mon Oct 13 00:20:59 2014 +0200 Ready for release
Sun Oct 12 21:18:36 2014 +0200 Flatten also for creating
Sun Oct 12 21:08:58 2014 +0200 Match all values on the arrays
Sun Oct 12 21:03:05 2014 +0200 Flattening the array, puppet passes around array of arrays...?
Sun Oct 12 19:45:14 2014 +0200 Start allowing arrays for ipv4
Thu Oct 9 22:44:04 2014 +0200 lxc_interface type, allow array of IPv4s
Thu Oct 9 22:42:38 2014 +0200 lxc type, allow array of IPv4s
Thu Oct 9 02:23:23 2014 +0200 Added restart parameter to lxc_interface
Thu Oct 9 02:22:50 2014 +0200 Removed fixme paramter, was c&p
Thu Oct 9 01:17:46 2014 +0200 Fixed clearing IPv4 gateway
Thu Oct 9 00:37:16 2014 +0200 Added restart to lxc provider
Tue Oct 7 00:06:07 2014 +0200 More info to README
Mon Oct 6 23:56:36 2014 +0200 Added restart parameter to lxc type
Mon Oct 6 23:49:25 2014 +0200 Added documentation to README
Sun Oct 5 23:58:06 2014 +0200 Fixed test for lxc_interface type.
Sun Oct 5 23:55:27 2014 +0200 Ban index 0 from lxc_interface provider.
Sun Oct 5 23:51:01 2014 +0200 Fixed destroy for lxc_interface provider.
Sun Oct 5 18:17:41 2014 +0200 Small fixes on lxc provider for network config.
Sun Oct 5 00:56:49 2014 +0200 Added ipv4_gateway to lxc provider
Sun Oct 5 00:44:13 2014 +0200 Added ipv4 to lxc provider
Sun Sep 28 19:11:39 2014 +0200 Added ipv4 and ipv4_gateway to lxc type
Sun Sep 28 13:09:25 2014 +0200 Added way to test ipv4 when liblxc >= 1.1.0 or < 1.1.0
Sun Sep 28 12:44:46 2014 +0200 Fixed test for ipv4 getter
Fri Sep 26 01:26:25 2014 +0200 ipv4 test almost done
Fri Sep 26 01:15:34 2014 +0200 fixed broken tests
Fri Sep 26 01:05:20 2014 +0200 Modified #FIXME to allow arrays on ipv4
Fri Sep 26 00:59:44 2014 +0200 A bit dirty, but works, it should be an array
Fri Sep 26 00:33:56 2014 +0200 Typo, seems to work
Fri Sep 26 00:28:07 2014 +0200 Worse or better?
Thu Sep 25 23:00:22 2014 +0200 Hopefull the getter for ipv4 is working, it's a workaround until liblxc > 1.0.5 is released
Wed Sep 24 01:15:37 2014 +0200 Seems the item has to cleared to avoid dups
Wed Sep 24 01:11:49 2014 +0200 missing #save_config in setters
Wed Sep 24 00:54:54 2014 +0200 ipv4 getter should be working now, skipping test until I find a good way for it.
Mon Sep 22 00:12:41 2014 +0200 Removed tags, have not found any useful use for it
Sun Sep 21 00:56:27 2014 +0200 Added note to fix/remove flags, down does not work
Sun Sep 21 00:55:11 2014 +0200 Added note to fix ipv4 as bindings do not return mask.
Sun Sep 21 00:53:21 2014 +0200 seems order matters here
Sun Sep 21 00:52:14 2014 +0200 @resource is not yet there, have to use self
Sat Sep 20 13:45:13 2014 +0200 lxc_interface should be ready for a real test
Sat Sep 20 00:26:18 2014 +0200 #create and its tests for lxc_interface
Mon Sep 15 00:35:42 2014 +0200 Initial work for lxc_interface provider
Sun Sep 14 23:34:31 2014 +0200 Container name is now required
Sun Sep 14 23:23:37 2014 +0200 Network type default to veth
Sun Sep 14 23:20:50 2014 +0200 Flags to 'up' and make container to be required.
Sun Sep 14 22:29:05 2014 +0200 Fixed test for parameters and add index.
Sun Sep 14 19:32:20 2014 +0200 Initial rspec tests for Lxc_interface type
Sun Sep 14 19:32:01 2014 +0200 Initial work for Lxc_interface type
Sat Sep 13 13:42:39 2014 +0200 Updated version on metadata.json and bumped to 0.2.1
Sat Sep 13 13:30:29 2014 +0200 Getting ready for the forge
Sat Sep 13 12:31:11 2014 +0200 gemfile.lock
Sat Sep 13 12:18:19 2014 +0200 Avoid duplicating travis runs
Sat Sep 13 12:10:31 2014 +0200 Adding build status
Sat Sep 13 12:05:17 2014 +0200 Trying to make Travis happy...
Sat Sep 13 12:02:17 2014 +0200 RVM versions
Sat Sep 13 11:54:52 2014 +0200 non-default Gemfile
Sat Sep 13 11:47:57 2014 +0200 non-interactive
Sat Sep 13 11:44:57 2014 +0200 Add lxc PPA, does travis run precise?
Sat Sep 13 11:40:40 2014 +0200 First attempt...travis.yml
Sat Sep 13 11:40:13 2014 +0200 Missing ruby-lxc
Sat Sep 13 11:30:20 2014 +0200 Getting ready for travis-ci
Fri Sep 12 01:11:17 2014 +0200 Author name, is name...
Tue Sep 9 01:44:39 2014 +0200 More and better looking tests
Tue Sep 9 01:44:18 2014 +0200 Better storage_options validation
Tue Sep 9 01:39:40 2014 +0200 Use resource instance variable
Sun Sep 7 20:09:44 2014 +0200 Initial tests for provider
Sun Sep 7 20:07:59 2014 +0200 Explicit rspec gems
Fri Sep 5 02:43:44 2014 +0200 #symbolize_hash private
Fri Sep 5 02:42:14 2014 +0200 added ruby-lxc
Thu Sep 4 00:21:51 2014 +0200 type tested
Thu Sep 4 00:21:26 2014 +0200 Added comment about not so good validation for storage_options parameter
Thu Sep 4 00:20:52 2014 +0200 back to default output for rspec
Wed Sep 3 01:41:23 2014 +0200 Partial tests for lxc type
Tue Sep 2 00:27:47 2014 +0200 Fixed metadata.json as it made catalog compilation to fail (?)
Tue Sep 2 00:27:13 2014 +0200 rspec options
Mon Sep 1 01:21:25 2014 +0200 More TODO
Mon Sep 1 01:20:10 2014 +0200 Added TODO section
Mon Sep 1 01:15:47 2014 +0200 Added Apache-2.0 license
Mon Sep 1 01:15:33 2014 +0200 Fixed metadata.json
Mon Sep 1 01:11:22 2014 +0200 README index
Mon Sep 1 01:10:12 2014 +0200 More informative README
Mon Sep 1 00:30:11 2014 +0200 Initial tests
Mon Sep 1 00:29:50 2014 +0200 More stuff working and added feature lxc
Mon Sep 1 00:29:17 2014 +0200 Puppet spec helper
Mon Sep 1 00:28:52 2014 +0200 Params, gem build deps, ...
Mon Sep 1 00:28:03 2014 +0200 Custom Rakefile
Mon Sep 1 00:27:20 2014 +0200 Bundler
Mon Sep 1 00:26:56 2014 +0200 Added basic fixtures file
Tue Aug 19 01:09:17 2014 +0200 Confined to ubuntu and state default to running
Tue Aug 19 00:35:36 2014 +0200 Storage backend support
Sun Aug 17 18:22:57 2014 +0000 Initial import, rudimentary initial provider
