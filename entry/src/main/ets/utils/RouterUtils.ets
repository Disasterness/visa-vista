import { BusinessError } from '@kit.BasicServicesKit'

export function routePageWithObjectParams(
  ctx: UIContext,
  url: string,
  params: object
): void {
  try {
    ctx.getRouter().pushUrl({
      url: url,
      params: params
    });
  } catch (err) {
    const code = (err as BusinessError).code;
    const msg  = (err as BusinessError).message;
    console.error(`pushUrl failed, code=${code}, msg=${msg}`);
  }
}

export function getParams(ctx: UIContext): object | undefined {
  try {
    const p = ctx.getRouter().getParams() as object
    return p
  } catch (err) {
    const code = (err as BusinessError).code
    const msg  = (err as BusinessError).message
    console.error(`getParams failed, code=${code}, msg=${msg}`)
    return undefined
  }
}