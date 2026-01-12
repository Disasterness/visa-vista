export class CountryVisaInfo {
  countryName: string
  passportRank: number
  noVisaCountries: number
  visaCountries: number
  eVisaCountries: number
  mediaName: string

  constructor(
    countryName: string,
    passportRank: number,
    noVisaCountries: number,
    visaCountries: number,
    eVisaCountries: number,
    mediaName: string) {
    this.countryName = countryName
    this.passportRank = passportRank
    this.noVisaCountries = noVisaCountries
    this.visaCountries = visaCountries
    this.eVisaCountries = eVisaCountries
    this.mediaName = mediaName
  }
}