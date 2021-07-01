import sgMail from '@sendgrid/mail';
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

export async function sendNewUserMail(name: string, link: string, email: string): Promise<void> {
    const msg = {
        to: email,
        from: 'no-reply@voltiac.dev',
        templateId: 'd-b1b46b9bac114a91a61731e239a48f3e',
        dynamicTemplateData: {
          name: name,
          link: link,
        },
      };
    await sgMail.send(msg);
}

export async function sendForgotMail(name:string, email: string, link: string): Promise<void> {
    const msg = {
        to: email,
        from: 'no-reply@voltiac.dev',
        templateId: 'd-b1b46b9bac114a91a61731e239a48f3e',
        dynamicTemplateData: {
          name: name,
          link: link,
        },
      };
    await sgMail.send(msg);
}