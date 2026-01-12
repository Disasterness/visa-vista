import { CountryVisaInfo } from '../model/CountryVisaInfo';
import { VISA_DATA } from '../utils/MockDataList';

export class VisaDataViewModel
{
  public getList(): CountryVisaInfo[] {
    return VISA_DATA;
  }
}