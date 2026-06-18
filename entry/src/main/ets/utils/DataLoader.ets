import { common } from '@kit.AbilityKit';
import { CountryVisaInfo } from '../model/CountryVisaInfo';
import { util } from '@kit.ArkTS';

export class DataLoader {
  public static async loadVisaData(context: common.Context): Promise<CountryVisaInfo[]> {
    try {
      const resourceManager = context.resourceManager;
      const data = await resourceManager.getRawFileContent('visaData.json');
      let decoder = util.TextDecoder.create('utf-8');
      let jsonString = decoder.decodeWithStream(data);
      let parsedData = JSON.parse(jsonString) as CountryVisaInfo[];
      return parsedData;
    } catch (error) {
      console.error('DataLoader loadVisaData error:', JSON.stringify(error));
      return [];
    }
  }
}
