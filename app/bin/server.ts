/*
|--------------------------------------------------------------------------
| HTTP Server
|--------------------------------------------------------------------------
|
| Este arquivo é o ponto de entrada para a execução do servidor HTTP.
| O Ignitor é o responsável por carregar a aplicação e configurar
| os hooks necessários para o runtime do AdonisJS.
|
*/

import { Ignitor, prettyPrintError } from '@adonisjs/core'

/**
 * URL do diretório raiz da aplicação.
 */
const APP_ROOT = new URL('../', import.meta.url)

/**
 * Iniciando a aplicação.
 */
new Ignitor(APP_ROOT, { deceleration: 'minimal' })
  .httpServer()
  .start()
  .catch((error) => {
    process.exitCode = 1
    prettyPrintError(error)
  })