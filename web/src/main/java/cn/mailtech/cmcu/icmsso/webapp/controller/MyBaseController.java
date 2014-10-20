package cn.mailtech.cmcu.icmsso.webapp.controller;

import cn.mailtech.ssh.common.service.context.BaseServiceContext;
import cn.mailtech.ssh.common.webapp.controller.BaseController;

public class MyBaseController extends BaseController {

    @Override
    protected BaseServiceContext initServiceContext(BaseServiceContext serviceContext) {
        super.initServiceContext(serviceContext);

        return serviceContext;
    }

}
