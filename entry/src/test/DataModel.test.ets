import { describe, it, expect } from '@ohos/hypium';
import { CountryVisaInfo } from '../main/ets/model/CountryVisaInfo';

export default function dataModelTest() {
  describe('DataModelTest', () => {
    it('testCountryVisaInfoConstructor', 0, () => {
      let info = new CountryVisaInfo('TestCountry', 10, 100, 50, 20, 'test_media', 'Test note');
      expect(info.countryName).assertEqual('TestCountry');
      expect(info.passportRank).assertEqual(10);
      expect(info.noVisaCountries).assertEqual(100);
      expect(info.visaCountries).assertEqual(50);
      expect(info.eVisaCountries).assertEqual(20);
      expect(info.mediaName).assertEqual('test_media');
      expect(info.note).assertEqual('Test note');
    });

    it('testCountryVisaInfoDefaultNote', 0, () => {
      let info = new CountryVisaInfo('TestCountry', 10, 100, 50, 20, 'test_media');
      expect(info.note).assertEqual('');
    });
  });
}
