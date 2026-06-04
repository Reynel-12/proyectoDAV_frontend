<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="restablecerContraseña.aspx.cs" Inherits="proyecto_frontend.Pages.restablecerContraseña" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="~/CSS/restablecerContraseña.css" />
    <title>Restablecer contraseña - InvControl Pro</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">

            <!-- ── Branding ── -->
            <div class="brand-header">
                <div class="brand-logo" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="2" y="2" width="9" height="9" rx="2" fill="white" opacity=".95" />
                        <rect x="13" y="2" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="2" y="13" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="13" y="13" width="9" height="9" rx="2" fill="white" opacity=".3" />
                    </svg>
                </div>
                <div class="brand-name">InvControl Pro</div>
                <div class="brand-tagline">Plataforma Web de Inventario</div>
            </div>

            <!-- ── Stepper ── -->
            <div class="stepper" role="list" aria-label="Pasos para restablecer contraseña">
                <div class="step-item" role="listitem">
                    <div class="step-circle" id="scStep1">1</div>
                    <span class="step-label" id="slStep1">Correo</span>
                </div>
                <div class="step-connector" id="conn1"></div>
                <div class="step-item" role="listitem">
                    <div class="step-circle" id="scStep2">2</div>
                    <span class="step-label" id="slStep2">Verificación</span>
                </div>
                <div class="step-connector" id="conn2"></div>
                <div class="step-item" role="listitem">
                    <div class="step-circle" id="scStep3">3</div>
                    <span class="step-label" id="slStep3">Nueva contraseña</span>
                </div>
            </div>

            <!-- ════════════════════════════════════
         PASO 1 — Ingresa tu correo
    ════════════════════════════════════ -->
            <asp:Panel ID="pnlStep1" runat="server" CssClass="reset-card" DefaultButton="btnEnviarCodigo">

                <div class="card-header">
                    <div class="card-header-icon blue" aria-hidden="true">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <h1 class="card-title">¿Olvidaste tu contraseña?</h1>
                    <p class="card-subtitle">
                        Ingresa el correo electrónico asociado a tu cuenta y te enviaremos
                        un código de verificación de 6 dígitos.
                    </p>
                </div>

                <div class="card-body">

                    <!-- Server-side validation summary -->
                    <asp:ValidationSummary
                        ID="vsSummary1"
                        runat="server"
                        CssClass="validation-summary"
                        HeaderText="Por favor corrige los siguientes errores:"
                        ValidationGroup="vgStep1"
                        DisplayMode="BulletList" />

                    <!-- Error de servidor (cuenta no encontrada, etc.) -->
                    <asp:Panel ID="pnlError1" runat="server" Visible="false">
                        <div class="alert error" role="alert">
                            <span class="alert-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <asp:Literal ID="litError1" runat="server" />
                        </div>
                    </asp:Panel>

                    <!-- Campo correo -->
                    <div class="field">
                        <label class="field-label" for="<%= txtCorreo.ClientID %>">
                            Correo electrónico <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-hint">El correo con el que accedes al sistema</div>
                        <div class="field-wrap">
                            <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="2" y="4" width="20" height="16" rx="2" />
                                <path d="M2 8l10 6 10-6" />
                            </svg>
                            <asp:TextBox
                                ID="txtCorreo"
                                runat="server"
                                CssClass="field-input no-right-icon"
                                TextMode="Email"
                                placeholder="usuario@empresa.com"
                                MaxLength="150"
                                autocomplete="email" />
                            <asp:RequiredFieldValidator
                                ID="rfvCorreo"
                                runat="server"
                                ControlToValidate="txtCorreo"
                                ErrorMessage="El correo electrónico es obligatorio."
                                Display="None"
                                ValidationGroup="vgStep1" />
                            <asp:RegularExpressionValidator
                                ID="revCorreo"
                                runat="server"
                                ControlToValidate="txtCorreo"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Ingresa un correo electrónico válido."
                                Display="None"
                                ValidationGroup="vgStep1" />
                        </div>
                    </div>

                </div>

                <div class="card-footer">
                    <asp:Button
                        ID="btnEnviarCodigo"
                        runat="server"
                        ValidationGroup="vgStep1"
                        OnClick="btnEnviarCodigo_Click"
                        CssClass="btn-primary"
                        Text="Enviar código de verificación" />

                    <div class="security-badge" role="note">
                        <span class="security-badge-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </span>
                        <span>El código es válido por <strong>10 minutos</strong> y solo puede usarse una vez.</span>
                    </div>
                </div>

            </asp:Panel>

            <!-- ════════════════════════════════════
         PASO 2 — Ingresa el código OTP
    ════════════════════════════════════ -->
            <asp:Panel ID="pnlStep2" runat="server" Visible="false" CssClass="reset-card" DefaultButton="btnVerificarCodigo">

                <div class="card-header">
                    <div class="card-header-icon amber" aria-hidden="true">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M18 8C18 4.686 15.314 2 12 2C8.686 2 6 4.686 6 8V11H4V20H20V11H18V8Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <circle cx="12" cy="16" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <h2 class="card-title">Verifica tu identidad</h2>
                    <p class="card-subtitle">
                        Hemos enviado un código de 6 dígitos a
                        <strong id="lblCorreoMostrar">
                            <asp:Literal ID="litCorreoMasked" runat="server" /></strong>.
                        Revisa tu bandeja de entrada.
                    </p>
                </div>

                <div class="card-body">

                    <asp:ValidationSummary
                        ID="vsSummary2"
                        runat="server"
                        CssClass="validation-summary"
                        HeaderText="Por favor corrige los siguientes errores:"
                        ValidationGroup="vgStep2"
                        DisplayMode="BulletList" />

                    <asp:Panel ID="pnlError2" runat="server" Visible="false">
                        <div class="alert error" role="alert">
                            <span class="alert-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <asp:Literal ID="litError2" runat="server" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlInfoCode" runat="server" Visible="false">
                        <div class="alert info" role="status" aria-live="polite">
                            <span class="alert-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 4H20V20H4V4Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 16L12 12L15 15L20 8" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            <asp:Literal ID="litInfoCode" runat="server" Text="Se reenvió el código correctamente." />
                        </div>
                    </asp:Panel>

                    <!-- Inputs de código OTP (6 dígitos) -->
                    <div class="field">
                        <label class="field-label">
                            Código de verificación <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="code-inputs" role="group" aria-label="Ingresa los 6 dígitos del código">
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd0" aria-label="Dígito 1" autocomplete="one-time-code" />
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd1" aria-label="Dígito 2" />
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd2" aria-label="Dígito 3" />
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd3" aria-label="Dígito 4" />
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd4" aria-label="Dígito 5" />
                            <input class="code-digit" type="text" inputmode="numeric" pattern="[0-9]"
                                maxlength="1" id="cd5" aria-label="Dígito 6" />
                        </div>
                        <div class="code-hint" aria-live="polite" id="codeHint">Ingresa los 6 dígitos del código recibido</div>
                        <asp:HiddenField ID="hfCodigo" runat="server" />
                        <asp:RequiredFieldValidator
                            ID="rfvCodigo"
                            runat="server"
                            ControlToValidate="hfCodigo"
                            ErrorMessage="Debes ingresar el código de verificación completo."
                            Display="None"
                            ValidationGroup="vgStep2" />
                        <asp:RegularExpressionValidator
                            ID="revCodigo"
                            runat="server"
                            ControlToValidate="hfCodigo"
                            ValidationExpression="^\d{6}$"
                            ErrorMessage="El código debe contener exactamente 6 dígitos numéricos."
                            Display="None"
                            ValidationGroup="vgStep2" />
                    </div>

                    <!-- Reenviar código -->
                    <div class="resend-row" aria-live="polite">
                        <span>¿No recibiste el código?</span>
                        <button class="btn-resend" id="btnResend" type="button" disabled>
                            Reenviar (<span class="resend-timer" id="resendTimer">60</span>s)
                        </button>
                        <asp:Button ID="btnReenviarCodigo" runat="server"
                            Text="Reenviar" Style="display: none"
                            OnClick="btnReenviarCodigo_Click" CausesValidation="false" />
                    </div>

                </div>

                <div class="card-footer">
                    <asp:Button
                        ID="btnVerificarCodigo"
                        runat="server"
                        ValidationGroup="vgStep2"
                        OnClick="btnVerificarCodigo_Click"
                        CssClass="btn-primary"
                        Text="Verificar código" />
                    <hr class="field-divider" />
                    <asp:Button
                        ID="btnVolverPaso1"
                        runat="server"
                        Text="← Cambiar correo"
                        CssClass="btn-ghost"
                        CausesValidation="false"
                        OnClick="btnVolverPaso1_Click" />
                </div>

            </asp:Panel>

            <!-- ════════════════════════════════════
         PASO 3 — Nueva contraseña
    ════════════════════════════════════ -->
            <asp:Panel ID="pnlStep3" runat="server" Visible="false" CssClass="reset-card" DefaultButton="btnGuardarContrasena">

                <div class="card-header">
                    <div class="card-header-icon blue" aria-hidden="true">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <h2 class="card-title">Crea tu nueva contraseña</h2>
                    <p class="card-subtitle">
                        Elige una contraseña segura que no hayas usado anteriormente en este sistema.
                    </p>
                </div>

                <div class="card-body">

                    <asp:ValidationSummary
                        ID="vsSummary3"
                        runat="server"
                        CssClass="validation-summary"
                        HeaderText="Por favor corrige los siguientes errores:"
                        ValidationGroup="vgStep3"
                        DisplayMode="BulletList" />

                    <asp:Panel ID="pnlError3" runat="server" Visible="false">
                        <div class="alert error" role="alert">
                            <span class="alert-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <asp:Literal ID="litError3" runat="server" />
                        </div>
                    </asp:Panel>

                    <!-- Nueva contraseña -->
                    <div class="field">
                        <label class="field-label" for="<%= txtNuevaContrasena.ClientID %>">
                            Nueva contraseña <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-wrap">
                            <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox
                                ID="txtNuevaContrasena"
                                runat="server"
                                CssClass="field-input"
                                TextMode="Password"
                                placeholder="Mínimo 8 caracteres"
                                MaxLength="100"
                                autocomplete="new-password" />
                            <button class="btn-pw-toggle" type="button"
                                id="togglePw1"
                                aria-label="Mostrar contraseña"
                                aria-pressed="false"
                                data-target="<%= txtNuevaContrasena.ClientID %>">
                                <svg id="eyeOpen1" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                                    <circle cx="12" cy="12" r="3" />
                                </svg>
                                <svg id="eyeClosed1" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" style="display: none">
                                    <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94" />
                                    <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19" />
                                    <line x1="1" y1="1" x2="23" y2="23" />
                                </svg>
                            </button>
                            <asp:RequiredFieldValidator
                                ID="rfvNuevaContrasena"
                                runat="server"
                                ControlToValidate="txtNuevaContrasena"
                                ErrorMessage="La nueva contraseña es obligatoria."
                                Display="None"
                                ValidationGroup="vgStep3" />
                            <asp:RegularExpressionValidator
                                ID="revNuevaContrasena"
                                runat="server"
                                ControlToValidate="txtNuevaContrasena"
                                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"
                                ErrorMessage="La contraseña no cumple con los requisitos mínimos de seguridad."
                                Display="None"
                                ValidationGroup="vgStep3" />
                        </div>

                        <!-- Medidor de fortaleza -->
                        <div class="strength-wrap" id="strengthWrap" aria-live="polite" aria-atomic="true">
                            <div class="strength-bars" aria-hidden="true">
                                <div class="strength-bar" id="sb1"></div>
                                <div class="strength-bar" id="sb2"></div>
                                <div class="strength-bar" id="sb3"></div>
                                <div class="strength-bar" id="sb4"></div>
                            </div>
                            <div class="strength-label" id="strengthLabel" aria-label="Fortaleza de la contraseña: "></div>
                        </div>

                        <!-- Requisitos visuales -->
                        <div class="req-list" role="list" aria-label="Requisitos de la contraseña">
                            <div class="req-item" id="req-len" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>8 caracteres mínimo</span>
                            </div>
                            <div class="req-item" id="req-upper" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Una mayúscula</span>
                            </div>
                            <div class="req-item" id="req-lower" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Una minúscula</span>
                            </div>
                            <div class="req-item" id="req-num" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Un número</span>
                            </div>
                            <div class="req-item" id="req-special" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Un carácter especial</span>
                            </div>
                        </div>

                    </div>

                    <!-- Confirmar contraseña -->
                    <div class="field" style="margin-top: 20px;">
                        <label class="field-label" for="<%= txtConfirmarContrasena.ClientID %>">
                            Confirmar contraseña <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-wrap">
                            <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M9 12l2 2 4-4" />
                                <rect x="3" y="11" width="18" height="11" rx="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox
                                ID="txtConfirmarContrasena"
                                runat="server"
                                CssClass="field-input"
                                TextMode="Password"
                                placeholder="Repite tu nueva contraseña"
                                MaxLength="100"
                                autocomplete="new-password" />
                            <button class="btn-pw-toggle" type="button"
                                id="togglePw2"
                                aria-label="Mostrar confirmación"
                                aria-pressed="false"
                                data-target="<%= txtConfirmarContrasena.ClientID %>">
                                <svg id="eyeOpen2" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                                    <circle cx="12" cy="12" r="3" />
                                </svg>
                                <svg id="eyeClosed2" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" style="display: none">
                                    <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94" />
                                    <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19" />
                                    <line x1="1" y1="1" x2="23" y2="23" />
                                </svg>
                            </button>
                            <asp:RequiredFieldValidator
                                ID="rfvConfirmar"
                                runat="server"
                                ControlToValidate="txtConfirmarContrasena"
                                ErrorMessage="Por favor confirma tu nueva contraseña."
                                Display="None"
                                ValidationGroup="vgStep3" />
                            <asp:CompareValidator
                                ID="cvContrasenas"
                                runat="server"
                                ControlToValidate="txtConfirmarContrasena"
                                ControlToCompare="txtNuevaContrasena"
                                ErrorMessage="Las contraseñas no coinciden."
                                Display="None"
                                ValidationGroup="vgStep3" />
                        </div>

                        <!-- Feedback de coincidencia (client-side) -->
                        <div id="matchFeedback" style="display: none; margin-top: 6px"></div>
                    </div>

                </div>

                <div class="card-footer">
                    <asp:Button
                        ID="btnGuardarContrasena"
                        runat="server"
                        ValidationGroup="vgStep3"
                        OnClick="btnGuardarContrasena_Click"
                        CssClass="btn-primary"
                        Text="Guardar nueva contraseña" />

                    <div class="security-badge" role="note" style="margin-top: 14px">
                        <span class="security-badge-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </span>
                        <span>Tu contraseña se almacena de forma cifrada. Nunca la compartimos con terceros.</span>
                    </div>
                </div>

            </asp:Panel>

            <!-- ════════════════════════════════════
         PASO 4 — Éxito (sin panel server)
    ════════════════════════════════════ -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="reset-card">
                <div class="success-screen">
                    <div class="success-anim" role="img" aria-label="Éxito">
                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M8 12L11 15L16 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        </svg>
                    </div>
                    <h2 class="success-title">¡Contraseña restablecida!</h2>
                    <p class="success-desc">
                        Tu contraseña fue actualizada exitosamente.
                        Ya puedes iniciar sesión con tus nuevas credenciales.
                    </p>
                    <div class="success-hint">
                        <span aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </span>
                        <span>Por seguridad, cerramos todas las sesiones activas de tu cuenta.</span>
                    </div>
                    <asp:Button
                        ID="btnIrAlLogin"
                        runat="server"
                        Text="Ir al inicio de sesión"
                        CssClass="btn-primary"
                        Style="margin-top: 8px; max-width: 300px"
                        CausesValidation="false"
                        OnClick="btnIrAlLogin_Click" />
                </div>
            </asp:Panel>

            <!-- ── Volver al login ── -->
            <div class="back-to-login">
                <span aria-hidden="true">←</span>
                <a href="Login.aspx" aria-label="Volver a la pantalla de inicio de sesión">Volver al inicio de sesión</a>
            </div>

        </div>
        <!-- /page-shell -->

        <script src="<%= ResolveUrl("~/JS/restabelerContraseña.js") %>"></script>

        <!-- Exponer el paso actual al JS sin postback -->
        <script>
            document.body.setAttribute('data-step', '<%= StepActual %>');
        </script>
    </form>
</body>
</html>
