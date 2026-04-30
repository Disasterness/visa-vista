import { CountryVisaInfo } from '../model/CountryVisaInfo';
import { DataLoader } from '../utils/DataLoader';
import { common } from '@kit.AbilityKit';

export class VisaDataViewModel {
  private countries: CountryVisaInfo[] = [];

  public async fetchCountryList(context: common.Context): Promise<CountryVisaInfo[]> {
    // Simulate a network delay
    await new Promise<void>((resolve) => setTimeout(resolve, 1500));

    if (this.countries.length === 0) {
      this.countries = await DataLoader.loadVisaData(context);
    }
    return this.countries;
  }

  // Maintaining this for backward compatibility if needed, though it might return empty initially
  public getList(): CountryVisaInfo[] {
    return this.countries;
  }
}
