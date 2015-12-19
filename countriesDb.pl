:-dynamic country/4.

country('Poland', 'Europe', 'Democracy', 'Unitary').
country('USA', 'North America', 'Democracy', 'Federation').
country('Russia', 'Europe', 'Democracy', 'Federation').
country('Great Britain', 'Europe', 'Monarchy', 'Unitary').

:-dynamic organization/3.
organization('UN', 'United Nations', 'Human rights').
organization('EU', 'European Union', 'Local integration').
organization('NATO', 'North Atlantic Treaty Organization', 'Militaristic').

:-dynamic belongs_to/2.
belongs_to('Poland', 'NATO').
belongs_to('Poland', 'EU').
belongs_to('Poland', 'UN').

belongs_to('USA', 'NATO').
belongs_to('USA', 'UN').

belongs_to('Russia', 'UN').

belongs_to('Great Britain', 'NATO').
belongs_to('Great Britain', 'EU').
belongs_to('Great Britain', 'UN').


getCountryInfo:-
	write('Enter country name: '), nl,
	read_line_to_codes(user_input, Codes),
	atom_codes(Country, Codes),
  country(Country, Continent, FormOfGovernment, FormOfAdministration),
	nl,
	write('===== COUNTRY INFO ====='), nl,
	write('Country name: '), write(Country), nl,
	write('Continent: '), write(Continent), nl,
	write('Form of government: '), write(FormOfGovernment), nl,
	write('Form of administration: '), write(FormOfAdministration), nl,
  write('Organizations the country belongs to: '), forall(belongs_to(Country, Org), (write(Org), write(' '))).

listAllCountries:-
  forall(country(Country, _, _, _), (write(Country), nl)).

listAllOrganizations:-
  forall(organization(Organization, _, _), (write(Organization), nl)).

createCountry:-
  write('Enter country name: '),
  read_line_to_codes(user_input, Codes1),
  atom_codes(Country, Codes1),
  write('Enter continent: '),
  read_line_to_codes(user_input, Codes2),
  atom_codes(Continent, Codes2),
  write('Enter form of government: '),
  read_line_to_codes(user_input, Codes3),
  atom_codes(FormOfGovernment, Codes3),
  write('Enter form of administration: '),
  read_line_to_codes(user_input, Codes4),
  atom_codes(FormOfAdministration, Codes4),
  assertz(country(Country, Continent, FormOfGovernment, FormOfAdministration)).

createOrganization:-
  write('Enter organization abbreviation: '),
  read_line_to_codes(user_input, Codes1),
  atom_codes(Organization, Codes1),
  write('Enter organization full name: '),
  read_line_to_codes(user_input, Codes2),
  atom_codes(OrganizationFullName, Codes2),
  write('Enter organization type (e.g. Militaristic): '),
  read_line_to_codes(user_input, Codes3),
  atom_codes(Type, Codes3),
  assertz(organization(Organization, OrganizationFullName, Type)).

addCountryToOrganization:-
  write('Enter country name: '),
  read_line_to_codes(user_input, Codes1),
  atom_codes(Country, Codes1),
  write('Enter organization: '),
  read_line_to_codes(user_input, Codes2),
  atom_codes(Organization, Codes2),
  assertz(belongs_to(Country, Organization)).

removeCountry:-
  write('Enter country name: '),
  read_line_to_codes(user_input, Codes),
  atom_codes(Country, Codes),
  retractall(country(Country, _, _, _)).

removeOrganization:-
  write('Enter organization name: '),
  read_line_to_codes(user_input, Codes),
  atom_codes(Organization, Codes),
  retractall(organization(Organization, _, _)).

removeCountryFromOrganization:-
  write('Enter country name: '),
  read_line_to_codes(user_input, Codes1),
  atom_codes(Country, Codes1),
  write('Enter organization: '),
  read_line_to_codes(user_input, Codes2),
  atom_codes(Organization, Codes2),
  retractall(belongs_to(Country, Organization)).
