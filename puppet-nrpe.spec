Name:           puppet-nrpe
Version:        0.1.0
Release:        1%{?dist}
Summary:        A puppet module that installs and configure NRPE service

Group:          System Environment/Libraries
License:        Apache v2
URL:            http://forge.puppetlabs.com/yguenane/nrpe
Source0:        http://forge.puppetlabs.com/yguenane/nrpe/%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:       puppet

%description
A puppet module that installs and configure NRPE service. It uses augeas
and augeasproviders to customize nrpe.cfg file.

%prep
%setup -n yguenane-nrpe-%{version}

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/etc/puppet/modules/nrpe/
cp -r lib manifests $RPM_BUILD_ROOT/etc/puppet/modules/nrpe/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_sysconfdir}/puppet/modules/*
%doc CHANGELOG README LICENSE

%changelog
* Fri Oct 5 2013  Yanis Guenane  <yguenane@gmail.com>  0.1.0
- Initial version

