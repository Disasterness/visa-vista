import localUnitTest from './LocalUnit.test';
import dataModelTest from './DataModel.test';

export default function testsuite() {
  localUnitTest();
  dataModelTest();
}
